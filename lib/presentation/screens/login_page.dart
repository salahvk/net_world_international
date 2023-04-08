import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/routes_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          // alignment: AlignmentDirectional.center,
          children: [
            SvgPicture.asset(
              AssetSvg.headerImage,
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  SvgPicture.asset(AssetSvg.logoRounded),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Welcome",
                    style: getMediumtStyle(
                        color: Colormanager.mainTextColor, fontSize: 25),
                  ),
                  SizedBox(
                    width: size.width * .6,
                    child: Text(
                      "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate.",
                      style: getMediumtStyle(
                          color: Colormanager.subTextColor, fontSize: 9),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colormanager.buttonColor,
                        // border: Border.all(color: Colormanager.primary),
                        borderRadius: BorderRadius.circular(7)),
                    width: size.width * .8,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 3),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 15,
                            ),
                            border: InputBorder.none,
                            hintText: 'Enter Your User Name',
                            hintStyle: getLightStyle(
                                color: Colormanager.mainTextColor,
                                fontSize: 12),
                          ),
                          style: getMediumtStyle(
                              color: Colormanager.primary, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colormanager.buttonColor,
                        // border: Border.all(color: Colormanager.primary),
                        borderRadius: BorderRadius.circular(7)),
                    width: size.width * .8,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 3),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 15,
                            ),
                            border: InputBorder.none,
                            hintText: 'Enter Password',
                            hintStyle: getLightStyle(
                                color: Colormanager.mainTextColor,
                                fontSize: 12),
                          ),
                          style: getMediumtStyle(
                              color: Colormanager.primary, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.mainScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Colormanager.buttonColor,
                          border: Border.all(color: Colormanager.primary),
                          borderRadius: BorderRadius.circular(7)),
                      width: size.width * .8,
                      height: 40,
                      child: Center(
                          child: Text(
                        "Login",
                        style: getMediumtStyle(
                            color: Colormanager.primary, fontSize: 9),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
