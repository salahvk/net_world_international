import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/asset_manager.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/domain/core/api_endPoint.dart';
import 'package:net_world_international/presentation/screens/add_item_screen.dart';
import 'package:net_world_international/presentation/widget/scale_up_animation.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(
      OptionPageEvent(),
    );
  }

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
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      print("kooi");
                      if (state is OptionPageState) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: SizedBox(
                            width: size.width * .8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Option",
                                      style: getMediumtStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                // const SizedBox(
                                //   width: 100,
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.userModel?.name ?? '',
                                      style: getMediumtStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    Text(
                                      "In publishing and graphic design,",
                                      style: getLightStyle(
                                          color: Colors.white, fontSize: 7),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "$endPoint/${state.userModel?.photoPath}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        const SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator()),
                      );
                    },
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
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ScaleUpAnimation(
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                splashColor: Colormanager.primary,
                                borderRadius: BorderRadius.circular(5),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return const AddItemScreen();
                                  }));
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
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
                              ),
                            ),
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          ),
                          ScaleUpAnimation(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
