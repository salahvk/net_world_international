import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
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
  bool emailValid = true;
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
                  padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
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
                                    "Edit Profile",
                                    style: getMediumtStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(EditProfileControllers
                                        .emailIdController.text);

                                // if (EditProfileControllers
                                //     .firstController.text.isNotEmpty) {
                                //   BlocProvider.of<LoginBloc>(context).add(
                                //     UpdateNameEvent(),
                                //   );
                                // }
                              },
                              child: const SizedBox(
                                width: 100,
                                height: 40,
                                child: Icon(
                                  Icons.done,
                                  size: 15,
                                  color: Colormanager.primary,
                                ),
                              ),
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
                            child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is LoggedIn) {
                                  return Stack(
                                    children: [
                                      // CircleAvatar(
                                      //   backgroundColor: Colors.white,
                                      //   radius: 53,
                                      //   child: Image.asset(
                                      //     'assets/man_image.png',
                                      //   ),
                                      // ),
                                      Container(
                                        width: 106,
                                        height: 106,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "$endPoint/${state.userModel?.photoPath}"),
                                            fit: BoxFit.cover,
                                          ),
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
                                                splashColor:
                                                    Colormanager.primary,
                                                customBorder:
                                                    const CircleBorder(),
                                                enableFeedback: true,
                                                excludeFromSemantics: true,
                                                onTap: () {
                                                  BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .add(
                                                    UpdateProfilePicEvent(),
                                                  );
                                                },
                                                child: const CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                                }
                                return Container();
                              },
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
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: TextField(
                          controller: EditProfileControllers.firstController,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: getLightStyle(
                                color: Colormanager.mainTextColor,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: TextField(
                          controller: EditProfileControllers.lastController,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: getLightStyle(
                                color: Colormanager.mainTextColor,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: TextField(
                          controller: EditProfileControllers.phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Phone',
                            hintStyle: getLightStyle(
                                color: Colormanager.mainTextColor,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: TextField(
                          controller: EditProfileControllers.emailIdController,
                          decoration: InputDecoration(
                            hintText: 'Email ID',
                            hintStyle: getLightStyle(
                                color: Colormanager.mainTextColor,
                                fontSize: 12),
                            enabledBorder: !emailValid
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  )
                                : const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                            focusedBorder: emailValid
                                ? const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colormanager.primary),
                                  )
                                : const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                          ),
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
