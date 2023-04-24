import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/presentation/screens/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isPasswordVIsible = false;
  void _saveForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      BlocProvider.of<LoginBloc>(context).add(
        NavigateToMainScreenEvent(),
      );
      // And do something here
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is Error) {
              AnimatedSnackBar.material("Invalid User",
                      type: AnimatedSnackBarType.error,
                      borderRadius: BorderRadius.circular(6),
                      duration: const Duration(seconds: 1))
                  .show(
                context,
              );
            } else if (state is LoggedIn) {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return const MainScreen();
              }));
            }
          },
          child: Stack(
            // alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(
                AssetSvg.headerImage,
              ),
              Center(
                child: Form(
                  key: _formKey,
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
                          style: getLightStyle(
                              color: Colormanager.subTextColor, fontSize: 9),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colormanager.buttonColor,
                            // border: Border.all(color: Colormanager.primary),
                            borderRadius: BorderRadius.circular(7)),
                        width: size.width * .8,
                        // height: 50,
                        child: Center(
                          child: TextFormField(
                            controller: LoginControllers.nameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  // vertical: 16.0,
                                  top: size.width * .03),
                              prefixIcon: const Icon(
                                Icons.person,
                                size: 15,
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .red, // Define the border color for error state
                                  width: 1.0,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter Your User Name',
                              hintStyle: getLightStyle(
                                  color: Colormanager.mainTextColor,
                                  fontSize: 9),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User Name';
                              }
                              return null;
                            },
                            style: getMediumtStyle(
                                color: Colormanager.textColor, fontSize: 12),
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
                        // height: 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Center(
                            child: TextFormField(
                              controller: LoginControllers.passWordController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    // vertical: 16.0,
                                    top: size.width * .03),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  size: 15,
                                ),
                                suffixIcon: InkWell(
                                  child: isPasswordVIsible
                                      ? const Icon(
                                          Icons.visibility_off,
                                          size: 18,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          size: 18,
                                        ),
                                  onTap: () {
                                    setState(() {
                                      isPasswordVIsible = !isPasswordVIsible;
                                    });
                                  },
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .red, // Define the border color for error state
                                    width: 1.0,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: 'Enter Password',
                                hintStyle: getLightStyle(
                                    color: Colormanager.mainTextColor,
                                    fontSize: 9),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                }
                                return null;
                              },
                              obscureText: isPasswordVIsible,
                              style: getMediumtStyle(
                                  color: Colormanager.textColor, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: _saveForm,
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colormanager.buttonColor,
                              border: Border.all(color: Colormanager.primary),
                              borderRadius: BorderRadius.circular(7)),
                          width: size.width * .8,
                          height: 40,
                          child: Center(
                            child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is Loading) {
                                  return const CircularProgressIndicator();
                                } else if (state is Error) {
                                  log("Error Occured");
                                }
                                return Text(
                                  "Login",
                                  style: getMediumtStyle(
                                      color: Colormanager.primary, fontSize: 9),
                                );
                              },
                            ),
                          ),
                        ),
                      )
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
