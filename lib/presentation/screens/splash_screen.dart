import 'package:flutter/material.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';

import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/presentation/screens/main_screen.dart';
import 'package:net_world_international/presentation/screens/url_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(
      NavigateToHomeScreenEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return const UrlPage();
              }));
            } else if (state is LoggedIn) {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return const MainScreen();
              }));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if ((state is Initial) || (state is Loading)) {
                return builIntro(size);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

Widget builIntro(Size size) {
  return Stack(
    children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetImages.landingBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .4,
            ),
            SizedBox(
              height: size.height * .5,
              child: Column(
                children: [
                  Image.asset('assets/logo_starting.png'),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Net World International",
                    style: getRegularStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
}
