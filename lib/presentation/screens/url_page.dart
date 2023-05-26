import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/routes_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({super.key});

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  void _saveForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      Hive.box("url").put('url_valid', "true");
      Navigator.pushNamed(context, Routes.paymentScreen);
    }
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 190,
                    ),
                    SvgPicture.asset(AssetSvg.logoRounded),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Enter Your URL",
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
                      height: 30,
                    ),
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                          color: Colormanager.buttonColor,
                          borderRadius: BorderRadius.circular(7)),
                      // height: 60,
                      child: Center(
                          child: TextFormField(
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value!.isEmpty || value != endPoint) {
                            return 'Invalid URL Address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                // vertical: 16.0,
                                ),
                            border: InputBorder.none,
                            // errorText: _hasError ? 'Invalid URL Address' : null,
                            hintText: 'Enter URL',
                            hintStyle: getLightStyle(
                                color: Colormanager.mainTextColor, fontSize: 9),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Define the border color for error state
                                width: 1.0,
                              ),
                            ),
                            errorStyle: getRegularStyle(
                              color: Colors.red,
                            ).copyWith()),
                      )),
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
                            child: Text(
                          "Register",
                          style: getMediumtStyle(
                              color: Colormanager.primary, fontSize: 9),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
