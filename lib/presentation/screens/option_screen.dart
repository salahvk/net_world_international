import 'package:flutter/material.dart';
import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'assets/header.png',
                fit: BoxFit.contain,
                width: size.width,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 0, 20),
                    child: Row(
                      children: [
                        Text(
                          "option",
                          style: getMediumtStyle(
                              color: Colors.black, fontSize: 10),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Robert",
                              style: getMediumtStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              "In publishing and graphic design,",
                              style: getLightStyle(
                                  color: Colors.black, fontSize: 7),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              minRadius: 60,
                              // foregroundImage: AssetImage(
                              //   'assets/man_image.png',
                              // ),
                              child: ClipOval(
                                child: Image(
                                  image: AssetImage('assets/man_image.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: size.width * .8,
                      height: size.height * .7,
                      decoration: BoxDecoration(
                        color: Colormanager.background,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  'assets/icon_items.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Item Master",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  'assets/icon_ShoppingCart.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Purchase",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.sales,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Sales",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.credit,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Debit Note",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.credit,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Credit Note",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.transfer,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Transfer",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.quote,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Quotation",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.marketLPO,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Market Purchase LPO",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.stockUpdate,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Stock Update",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.barcode,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Barcode",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.reports,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Reports",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.import,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Import Live DB",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  IconImages.sync,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                "Sync with Live DB",
                                style: getLightStyle(
                                    color: Colormanager.textColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
