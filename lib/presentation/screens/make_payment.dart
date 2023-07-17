import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/routes_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        // alignment: AlignmentDirectional.center,
        children: [
          SvgPicture.asset(
            AssetSvg.headerImage,
                 width: size.width,
          ),
          Center(
            child: Column(
              children: [
                 SizedBox(
                   height: size.width > 500
                                ? size.height * .32
                                : size.height * .2,
                ),
                SvgPicture.asset(AssetSvg.logoRounded),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Make Your Payment",
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.loginPage);
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
                      "Pay Now",
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
    );
  }
}
