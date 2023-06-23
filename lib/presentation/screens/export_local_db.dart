import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/core/util/animated_snackbar.dart';
import 'package:sqflite/sqflite.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final _connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  Database? database;

  deleteTable() async {
    final Database database = await openDatabase('my_database.db');

    // Execute the SQL statement to drop the table
    await database.execute('DROP TABLE IF EXISTS PTempPurchaseMaster2');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      database = await openDatabase('my_database.db');
      final List<Map<String, dynamic>> rows =
          await database!.query('PTempPurchaseMaster2');
      print(rows);

      _connectToSqlServerDirectlyPlugin
          .initializeConnection(
        '13.251.68.128:1433',
        'testdbforcust',
        'sa',
        'reallyStrongPwd123',
      )
          .then((value) {
        final values = rows.map((data) =>
            "('${data['Total']}','${data['SupplierId']}','${data['VoucherNo']}','${data['CCode']}','${data['CurrencyId']}','${data['ExchangeRate']}','${data['PurTotal']}','${data['PurDiscount']}','${data['PurFreight']}')");
        final query =
            'INSERT INTO dbo.PTempPurchaseMaster(Total,SupplierId,VoucherNo,CCode,CurrencyId,ExchangeRate,PurTotal,PurDiscount,PurFreight) VALUES '
            '${values.join(',')}';

        if (value) {
          try {
            _connectToSqlServerDirectlyPlugin
                .getStatusOfQueryResult(query)
                .then((value) async {
              if (value.runtimeType == String) {
                onError(value.toString());
              } else {
                print(value);
                await deleteTable();
                showSuccessAnimatedSnackBar(
                    context, "Local DB Exported Successfully");
                await Future.delayed(const Duration(seconds: 2));
                Navigator.pop(context);
              }
            });
          } catch (error) {
            onError(error.toString());
          }
        } else {
          onError('Failed to Export!');
        }
      });
    });
  }

  void onError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 6),
        padding: const EdgeInsets.all(8.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Exporting Local Db",
              style:
                  getRegularStyle(color: Colormanager.textColor, fontSize: 18),
            ),
            LottieBuilder.asset("assets/lottie/sync.json"),
          ],
        ),
      ),
    );
  }
}
