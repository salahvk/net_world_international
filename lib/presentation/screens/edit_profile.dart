import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/presentation/screens/home_screen.dart';
import 'package:net_world_international/presentation/screens/option_screen.dart';
import 'package:net_world_international/presentation/screens/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: 60.0,
        items: <Widget>[
          Image.asset(
            "assets/homeIcon.png",
            width: 30,
            height: 30,
            color: Colors.white,
          ),
          const Icon(
            Icons.person_outline,
            size: 30,
            color: Colors.white,
          ),
          const Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit Profile",
                              style: getMediumtStyle(
                                  color: Colors.black, fontSize: 10),
                            ),
                            const Icon(
                              Icons.done,
                              size: 15,
                              color: Colormanager.primary,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(4, 4.5),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  child: Image.asset(
                                    'assets/man_image.png',
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(2, 2.5),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        shape: const CircleBorder(),
                                        color: Colors.white,
                                        child: InkWell(
                                          splashColor: Colormanager.primary,
                                          customBorder: const CircleBorder(),
                                          enableFeedback: true,
                                          excludeFromSemantics: true,
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.transparent,
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Text(
                            "Your Information",
                            style: getRegularStyle(
                                color: Colormanager.textColor, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          hintStyle: getLightStyle(
                              color: Colormanager.mainTextColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          hintStyle: getLightStyle(
                              color: Colormanager.mainTextColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          hintStyle: getLightStyle(
                              color: Colormanager.mainTextColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email ID',
                          hintStyle: getLightStyle(
                              color: Colormanager.mainTextColor, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
