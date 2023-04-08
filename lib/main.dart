import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/splashBloc/splash_bloc.dart';
import 'package:net_world_international/core/routes_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => SplashScreenBloc()),
        // BlocProvider(create: (ctx) => getIt<SearchBloc>()),
        // BlocProvider(create: (ctx) => getIt<FastLaughBloc>()),
        // BlocProvider(create: (ctx) => getIt<HotAndNewBloc>()),
        // BlocProvider(create: (ctx) => getIt<HomepageBloc>()),
      ],
      child: MaterialApp(
        title: 'Net World International',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home: const SplashScreen(),
        initialRoute: Routes.splashScreen,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
