import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/presentation/screens/home_screen.dart';
import 'package:net_world_international/presentation/screens/option_screen.dart';
import 'package:net_world_international/presentation/screens/profile_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  int _selectedIndex = 1;
  // int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const OptionScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: 60.0,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              "assets/homeIcon.png",
              width: 25,
              height: 25,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              "assets/icon_user.png",
              width: 25,
              height: 25,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              "assets/option.png",
              width: 25,
              height: 25,
              color: Colors.white,
            ),
          ),
        ],
        color: Colormanager.primary,
        buttonBackgroundColor: Colormanager.primary,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            BlocProvider.of<LoginBloc>(context).add(
              ProfilePageEvent(),
            );
          }
        },
        letIndexChange: (index) => true,
      ),
      backgroundColor: Colors.white,
      body: _selectedIndex != 1
          ? _screens[_selectedIndex]
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                                size: 10,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Change Password",
                                style: getMediumtStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Reset Your Password",
                            style: getRegularStyle(
                                color: Colormanager.textColor, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying ",
                        style: getLightStyle(
                            color: Colormanager.mainTextColor, fontSize: 10),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Current Password',
                          hintStyle: getLightStyle(
                              color: Colormanager.mainTextColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle: getLightStyle(
                              color: Colormanager.mainTextColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: getLightStyle(
                              color: Colormanager.mainTextColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colormanager.primary,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          "Update Password",
                          style: getLightStyle(
                              color: Colormanager.background, fontSize: 13),
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
