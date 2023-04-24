import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/presentation/screens/home_screen.dart';
import 'package:net_world_international/presentation/screens/option_screen.dart';
import 'package:net_world_international/presentation/screens/profile_screen.dart';

class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({super.key});

  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
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
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                "Get Help",
                                style: getMediumtStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset("assets/svg/help.svg"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "How can we help you",
                                style: getRegularStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                              Text(
                                "In publishing and graphic design, Lorem ipsum is \naplaceholder text commonly used to demonstrate.",
                                style: getLightStyle(
                                    color: Colormanager.mainTextColor,
                                    fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colormanager.lightBlue,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colormanager.primary)),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: SvgPicture.asset(
                                "assets/svg/help.svg",
                                width: 15,
                              ),
                            ),
                            Text(
                              "Contact Live Chat",
                              style: getRegularStyle(
                                  color: Colormanager.textColor, fontSize: 13),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colormanager.lightBlue,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colormanager.primary)),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Image.asset(
                                AssetImages.emailIcon,
                                width: 12,
                              ),
                            ),
                            Text(
                              "Send us an E-mail",
                              style: getRegularStyle(
                                  color: Colormanager.textColor, fontSize: 13),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
