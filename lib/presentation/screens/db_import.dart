import 'dart:convert';
import 'dart:io';

import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progresso/progresso.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbImport extends StatefulWidget {
  const DbImport({super.key});

  @override
  State<DbImport> createState() => _DbImportState();
}

class _DbImportState extends State<DbImport> {
  final _connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  bool isLoading = false;
  int tableNo = 0;
  String tableNm = '';
  int no = 1;
  int rowC = 0;
  int rowProgression = 0;
  bool isFetching = false;
  bool isLinearProgressionEn = false;

  Future<List<String>> readTableNamesFromCSV() async {
    final String data = await rootBundle.loadString('assets/tablenames.csv');
    final List<String> tableNames = const LineSplitter().convert(data);
    return tableNames;
  }

  Future<Database> initializeDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'my_database.db');

    // Delete the database if it already exists (for testing purposes)
    await deleteDatabase(dbPath);

    final Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS MyTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tableName TEXT,
        rowJson TEXT
      )
    ''');
    });

    return database;
  }

  void fetchDb() {
    setState(() {
      isLoading = true;
    });

    _connectToSqlServerDirectlyPlugin
        .initializeConnection(
      '13.251.68.128:1433',
      'testdbforcust',
      'sa',
      'reallyStrongPwd123',
    )
        .then((value) async {
      if (value) {
        try {
          final tableNames = await readTableNamesFromCSV();
          // for (final tableName in tableNames) {
          //   setState(() {
          //     tableNo = no;
          //     tableNm = tableName;
          //   });
          //   no++;
          //   final rowCountQuery =
          //       'SELECT COUNT(*) AS row_count FROM dbo.$tableName';
          //   final selectQuery = 'SELECT * FROM dbo.$tableName';

          //   final rowCountResult = await _connectToSqlServerDirectlyPlugin
          //       .getRowsOfQueryResult(rowCountQuery);
          //   final rowCount =
          //       int.parse(rowCountResult[0]['row_count'].toString());
          //   // log(rowCount.toString());

          //   const batchSize = 30000; // Adjust the batch size as needed
          //   final iterations = (rowCount / batchSize).ceil();

          //   for (int i = 0; i < iterations; i++) {
          //     // log(iterations.toString());
          //     // log(i.toString());
          //     final offset = i * batchSize;
          //     final query =
          //         '$selectQuery ORDER BY (SELECT NULL) OFFSET $offset ROWS FETCH NEXT $batchSize ROWS ONLY';

          //     final result = await _connectToSqlServerDirectlyPlugin
          //         .getRowsOfQueryResult(query);
          //     final rows = result.cast<Map<String, dynamic>>();

          //     // Log or process the fetched rows
          //     print(rows);

          //   }
          //   Hive.box("db").put(tableName, '');
          // }
          final Database database = await initializeDatabase();

          for (final tableName in tableNames) {
            setState(() {
              tableNo = no;
              tableNm = tableName;
            });
            no++;
            final rowCountQuery =
                'SELECT COUNT(*) AS row_count FROM dbo.$tableName';
            final selectQuery = 'SELECT * FROM dbo.$tableName';

            final rowCountResult = await _connectToSqlServerDirectlyPlugin
                .getRowsOfQueryResult(rowCountQuery);
            final rowCount =
                int.parse(rowCountResult[0]['row_count'].toString());

            const batchSize = 30000; // Adjust the batch size as needed
            final iterations = (rowCount / batchSize).ceil();

            for (int i = 0; i < iterations; i++) {
              if (iterations > 1) {
                setState(() {
                  isLinearProgressionEn = true;
                  rowC = iterations;
                  rowProgression = i;
                });
              } else {
                setState(() {
                  isLinearProgressionEn = false;
                });
              }
              print(iterations.toString());
              print(i.toString());
              final offset = i * batchSize;
              final query =
                  '$selectQuery ORDER BY (SELECT NULL) OFFSET $offset ROWS FETCH NEXT $batchSize ROWS ONLY';

              final result = await _connectToSqlServerDirectlyPlugin
                  .getRowsOfQueryResult(query);
              final rows = result.cast<Map<String, dynamic>>();

              // Store rows in the SQLite database using batch operations
              await database.transaction((txn) async {
                final batch = txn.batch(); // Create a batch object
                for (final row in rows) {
                  final rowJson =
                      jsonEncode(row); // Convert the row to JSON string
                  print(rowJson);
                  batch.insert(
                      'MyTable', {'tableName': tableName, 'rowJson': rowJson});
                }
                await batch.commit(); // Execute the batch operation
              });
            }
          }
        } catch (error) {
          // onError(error.toString());
        }
      } else {
        onError('Failed to Connect!');
      }
    });
  }

  void onError(String message) {
    setState(() {
      isLoading = false;
    });
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

  Future<void> showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevent user from tapping outside to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Are you sure you want to delete the previously imported database?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog box
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog box
                fetchDb();
                // Add your code here to perform the delete action
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> isDatabaseExists() async {
    final String databasesPath = await getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'my_database.db');
    final File databaseFile = File(dbPath);

    return databaseFile.exists();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final isDbAvaiable = await isDatabaseExists();
      if (isDbAvaiable) {
        showDeleteConfirmationDialog();
      } else {
        fetchDb();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Loading Status"),
            const SizedBox(
              height: 5,
            ),
            Text("Fetched $tableNo 0f 481 Tables"),
            const SizedBox(
              height: 10,
            ),
            Text("Fetching Table : $tableNm"),
            // LottieBuilder.asset(
            //   // fit: BoxFit.fitWidth,
            //   "assets/import_anim.json",
            //   repeat: true,
            // ),

            isLinearProgressionEn
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text("$rowProgression of $rowC"),
                  )
                : Container(),

            isLinearProgressionEn
                ? Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Progresso(
                        progress: rowProgression / rowC,
                        progressColor: Colors.red,
                        backgroundColor: Colors.lightBlue),
                  )
                : Container(),
            const SizedBox(height: 30),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 16.0,
              animation: false,
              percent: tableNo / 481,
              center: Text(
                "${((tableNo / 481) * 100).toStringAsFixed(2)}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: const Text(
                "Fetching Database",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
