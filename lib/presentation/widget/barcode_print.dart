import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/core/util/animated_snackbar.dart';
import 'package:net_world_international/core/util/print_page.dart';
import 'package:net_world_international/infrastructure/item_imp.dart';

class BarcodePrint extends StatefulWidget {
  const BarcodePrint({super.key});

  @override
  State<BarcodePrint> createState() => _BarcodePrintState();
}

class _BarcodePrintState extends State<BarcodePrint> {
  bool isBarCodePrintable = false;
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Container(
      // width: size.width * .8,
      // height: size.height * .7,
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name",
                                style: getRegularStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            // width: size.width * .35,
                            child: TextField(
                                controller: PrintControllers.name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.5),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colormanager.primary),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 2, 76, 136)),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Barcode",
                  style: getRegularStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              // width: size.width * .35,
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: PrintControllers.barcode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.5),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () async {
                        print(PrintControllers.barcode.text);
                        final itemFetch = await ItemImp().getItemByBar();

                        itemFetch.fold((falure) {
                          return setState(() {
                            showAnimatedSnackBar(context, "No Barcode Found");
                            setState(() {
                              isBarCodePrintable = false;
                            });
                            PrintControllers.clearControllers();
                          });
                        }, (success) {
                          showSuccessAnimatedSnackBar(
                              context, "Barcode Fetched");
                          setState(() {
                            isBarCodePrintable = true;
                          });
                        });
                      },
                      child: const Icon(Icons.arrow_forward_rounded),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colormanager.primary),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 76, 136)),
                    ),
                  )),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // BlocBuilder<LoginBloc, LoginState>(
            //   builder: (context, state) {
            //     if (state is OptionPageState) {
            //       return

            isBarCodePrintable
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: PrintControllers.barcode.text,
                      // width: 100,
                      height: 100,
                    ),
                  )
                : Container(),
            //     }
            //     return Container();
            //   },
            // ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Selling Price",
                                style: getRegularStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: size.width * .35,
                            child: TextField(
                                controller: PrintControllers.sellingPrice,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.5),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colormanager.primary),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 2, 76, 136)),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Cost Price",
                            style: getRegularStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 40,
                        width: size.width * .35,
                        child: TextField(
                            controller: PrintControllers.costPrice,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.5),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colormanager.primary),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 2, 76, 136)),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // printBarcodeDetails();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PrintPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colormanager.teritiory,
                        border: Border.all(color: Colormanager.primary),
                      ),
                      child: Center(
                          child: Text(
                        "Item Print",
                        style: getRegularStyle(
                            color: Colormanager.primary, fontSize: 10),
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colormanager.primary),
                      color: Colormanager.teritiory,
                    ),
                    child: Center(
                        child: Text(
                      "Shelf Print",
                      style: getRegularStyle(
                          color: Colormanager.primary, fontSize: 10),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colormanager.primary),
                      color: Colormanager.teritiory,
                    ),
                    child: Center(
                        child: Text(
                      "Jewellery",
                      style: getRegularStyle(
                          color: Colormanager.primary, fontSize: 10),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
