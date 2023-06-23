import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';

import 'package:net_world_international/core/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("token");
  await Hive.openBox("url");
  await Hive.openBox("db");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => LoginBloc()),
      ],
      child: MaterialApp(
        title: 'Net World International',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home: const ProductPurchasePage(),
        initialRoute: Routes.splashScreen,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
