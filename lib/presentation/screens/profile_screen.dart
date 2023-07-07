import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:net_world_international/presentation/widget/scale_up_animation.dart';
import 'package:net_world_international/presentation/widget/translate_up_animation.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/routes_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/presentation/widget/diologue.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(
      ProfilePageEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final endPoint = Hive.box("url").get('endpoint');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
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
                      "Profile",
                      style: getMediumtStyle(color: Colors.black, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is ProfilePageState) {
                    return Row(
                      children: [
                        ScaleUpAnimation(
                          child: Container(
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
                                Container(
                                  width: 80,
                                  height: 80,
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
                                          splashColor: Colormanager.primary,
                                          customBorder: const CircleBorder(),
                                          enableFeedback: true,
                                          excludeFromSemantics: true,
                                          onTap: () {
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(
                                              UpdateProfilePicEvent(),
                                            );
                                          },
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
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ScaleUpAnimation(
                              child: Text(
                                state.userModel?.name ?? '',
                                style: getMediumtStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ),
                            ScaleUpAnimation(
                              child: Text(
                                "johnrob@gmail.com",
                                style: getLightStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ScaleUpAnimation(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.editProfile);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colormanager.primary,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 80,
                                  height: 25,
                                  child: Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: getLightStyle(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 50,
              ),
              TranslateUpAnimation(
                duration: const Duration(milliseconds: 900),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.changePassword);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon _edit.png",
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Change Password",
                        style: getRegularStyle(
                            color: Colormanager.textColor, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TranslateUpAnimation(
                duration: const Duration(milliseconds: 1000),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.getHelp);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon_help.png",
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Get Help",
                        style: getRegularStyle(
                            color: Colormanager.textColor, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TranslateUpAnimation(
                duration: const Duration(milliseconds: 1100),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const LogoutDialog(),
                        barrierDismissible: true);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon_logout.png",
                        width: 20,
                        height: 20,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Log Out",
                        style: getRegularStyle(
                            color: Colormanager.textColor, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
