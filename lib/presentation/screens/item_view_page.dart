import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/core/util/animated_snackbar.dart';
import 'package:net_world_international/infrastructure/add_item_imp.dart';
import 'package:net_world_international/infrastructure/item_imp.dart';
import 'package:net_world_international/presentation/screens/add_item_screen.dart';
import 'package:net_world_international/presentation/widget/barcode_print.dart';
import 'package:net_world_international/presentation/widget/itemview_row.dart';

class ItemViewPage extends StatefulWidget {
  const ItemViewPage({super.key});

  @override
  State<ItemViewPage> createState() => _ItemViewPageState();
}

class _ItemViewPageState extends State<ItemViewPage> {
  bool isAlterBarCodeVisible = false;
  bool isPrint = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PrintControllers.barcode.text =
          ItemMasterCloneControllers.cbarCodeController.text;
      await ItemImp().getItemByBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
            child: Column(
              children: [
                Container(
                  width: w,
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
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                ItemMasterCloneControllers.clone();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (ctx) {
                                  return const AddItemScreen(
                                    isUpdating: true,
                                  );
                                }));
                              },
                              child: const Icon(Icons.edit)),
                        ],
                      ),
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text("Barcode",
                                  style: getRegularStyle(
                                      color: Colormanager.textColor,
                                      fontSize: 14)),
                            ),
                            BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: ItemMasterCloneControllers
                                  .cbarCodeController.text,
                              width: w * .6,
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ItemViewRow(
                    key1: 'Name',
                    value: ItemMasterCloneControllers.cnameController.text),

                ItemViewRow(
                    key1: 'Arabic Name',
                    value: ItemMasterCloneControllers.carabicController.text),

                ItemViewRow(
                    key1: 'Department',
                    value: ItemMasterCloneControllers
                        .cdepartmentNameController.text),

                ItemViewRow(
                    key1: 'Category',
                    value: ItemMasterCloneControllers
                        .ccategoryNameController.text),

                // ItemViewRow(
                //     key1: 'Brand',
                //     value: ItemMasterCloneControllers.cnameController.text),
                // const Divider(
                //   thickness: 1,
                // ),
                ItemViewRow(
                    key1: 'Supplier',
                    value: ItemMasterCloneControllers
                        .csupplierNameController.text),
                // const Divider(
                //   thickness: 1,
                // ),
                // ItemViewRow(
                //     key1: 'Unit',
                //     value: ItemMasterCloneControllers.cnameController.text),

                ItemViewRow(
                    key1: 'Tax Name',
                    value: ItemMasterCloneControllers.cdefTaxName.text),

                ItemViewRow(
                    key1: 'Rack No',
                    value: ItemMasterCloneControllers.crackNoController.text),

                ItemViewRow(
                    key1: 'Shelf No',
                    value: ItemMasterCloneControllers.cshelfNoController.text),

                ItemViewRow(
                    key1: 'Cost Price',
                    value:
                        ItemMasterCloneControllers.ccostPriceController.text),

                ItemViewRow(
                    key1: 'Cost With Tax',
                    value:
                        ItemMasterCloneControllers.ccostWithTaxController.text),
                // const Divider(
                //   thickness: 1,
                // ),
                // ItemViewRow(
                //     key1: 'Margin %',
                //     value:
                //         "${ItemMasterCloneControllers.cmarginPerController.text}%"),
                // const Divider(
                //   thickness: 1,
                // ),
                // ItemViewRow(
                //     key1: 'Margin \$',
                //     value: ItemMasterCloneControllers.cmarginController.text),

                ItemViewRow(
                    key1: 'Selling Price',
                    value: ItemMasterCloneControllers.csellingPController.text),

                // ItemViewRow(
                //     key1: 'Selling With Tax',
                //     value: ItemMasterCloneControllers
                //         .csellingPriceWithTaxController.text),
                // const Divider(
                //   thickness: 1,
                // ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                          // ItemMasterCloneControllers.clone();
                          ItemMasterCloneControllers.clone();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) {
                            return const AddItemScreen(
                              isUpdating: true,
                            );
                          }));
                        },
                        child: Container(
                          // width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colormanager.teritiory,
                          ),
                          child: Center(
                              child: Text(
                            "Clone",
                            style: getRegularStyle(
                                color: Colormanager.primary, fontSize: 10),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isPrint = !isPrint;
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colormanager.teritiory,
                          ),
                          child: Center(
                              child: Text(
                            "Print",
                            style: getRegularStyle(
                                color: Colormanager.primary, fontSize: 10),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                isPrint ? const BarcodePrint() : Container(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Alternative",
                        style: getSemiBoldStyle(
                            color: Colormanager.textColor, fontSize: 14)),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isAlterBarCodeVisible = !isAlterBarCodeVisible;
                          });
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            Text("Add New"),
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                isAlterBarCodeVisible
                    ? Container(
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
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text("Barcode",
                                        style: getRegularStyle(
                                            color: Colormanager.textColor,
                                            fontSize: 14)),
                                  ),
                                  BlocBuilder<LoginBloc, LoginState>(
                                    builder: (context, state) {
                                      if (state is OptionPageState) {
                                        // AlterUnitControllers.barcodeAltText
                                        //     .text = state.barCode2 ?? '';
                                        // AlterUnitControllers.barcodeAlt.text =
                                        //     state.barCode2 ?? '';
                                        // AlterUnitControllers.barcodeAltText
                                        //     .text = state.barCode2 ?? '';
                                        // return BarcodeWidget(
                                        //   barcode: Barcode.code128(),
                                        //   data: AlterUnitControllers
                                        //       .barcodeAlt.text,
                                        //   width: w * .6,
                                        //   height: 100,
                                        // );
                                        print("object");
                                        print(AlterUnitControllers
                                            .barcodeAlt.text);
                                        print(AlterUnitControllers
                                            .barcodeAltText.text);

                                        return AlterUnitControllers
                                                    .barcodeAltText.text !=
                                                state.barCode2
                                            ? BarcodeWidget(
                                                barcode: Barcode.code128(),
                                                data: AlterUnitControllers
                                                    .barcodeAltText.text,
                                                // width: 100,
                                                height: 100,
                                              )
                                            : BarcodeWidget(
                                                barcode: Barcode.code128(),
                                                data: state.barCode2 ?? '',
                                                // width: 100,
                                                height: 100,
                                              );
                                      }
                                      return Container();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              Row(children: [
                                Expanded(
                                  child: SizedBox(
                                    // height: 50,
                                    child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            AlterUnitControllers.barcodeAltText,
                                        decoration: InputDecoration(
                                          hintText: "Barcode",
                                          hintStyle: getRegularStyle(
                                              color: Colors.grey, fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                color: Colormanager.amber),
                                            // borderRadius: BorderRadius.circular(5)
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 2, 76, 136)),
                                          ),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    if (state is OptionPageState) {
                                      return Material(
                                        color: Colormanager.teritiory,
                                        borderRadius: BorderRadius.circular(5),
                                        child: InkWell(
                                          splashColor: Colormanager.primary,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          onTap: () {
                                            setState(() {
                                              AlterUnitControllers.barcodeAlt
                                                  .clear();
                                            });

                                            // setState(() {
                                            //   // isBarCodeGen = true;

                                            //   AlterUnitControllers.barcodeAlt
                                            //       .clear();
                                            //   if (AlterUnitControllers
                                            //       .barcodeAlt.text.isEmpty) {
                                            //     AlterUnitControllers
                                            //             .barcodeAlt.text =
                                            //         state.barCode2 ?? '';
                                            //   }
                                            // });
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.add_circle_outline,
                                                  size: 12,
                                                  color: Colormanager.primary,
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "Generate",
                                                  style: getRegularStyle(
                                                      color:
                                                          Colormanager.primary,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            )),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ]),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Selling Price",
                                              style: getRegularStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            border: Border.all(
                                              color: Colormanager.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextField(
                                            controller:
                                                ItemMasterCloneControllers
                                                    .csellingPController,
                                            keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Cost Price",
                                              style: getRegularStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            border: Border.all(
                                              color: Colormanager.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextField(
                                            controller:
                                                ItemMasterCloneControllers
                                                    .ccostPriceController,
                                            keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Contain",
                                              style: getRegularStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            border: Border.all(
                                              color: Colormanager.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextField(
                                            controller:
                                                AlterUnitControllers.contain,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Alt Name",
                                              style: getRegularStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            border: Border.all(
                                              color: Colormanager.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextField(
                                            controller:
                                                AlterUnitControllers.altName,
                                            // keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Pluno",
                                              style: getRegularStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            border: Border.all(
                                              color: Colormanager.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextField(
                                            controller:
                                                AlterUnitControllers.pluno,
                                            // keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Ref Code",
                                              style: getRegularStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            border: Border.all(
                                              color: Colormanager.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextField(
                                            controller:
                                                AlterUnitControllers.refcode,
                                            // keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                    onPressed: () {
                                      saveAlternateBarCode();
                                    },
                                    child: const Text("Save")),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveAlternateBarCode() async {
    if (AlterUnitControllers.contain.text.isEmpty) {
      showAnimatedSnackBar(context, "Enter Contain");
    } else if (AlterUnitControllers.altName.text.isEmpty) {
      showAnimatedSnackBar(context, "Enter Alternate Name");
    } else if (AlterUnitControllers.pluno.text.isEmpty) {
      showAnimatedSnackBar(context, "Enter Pluno");
    } else if (AlterUnitControllers.refcode.text.isEmpty) {
      showAnimatedSnackBar(context, "Enter Ref Code");
    } else {
      final s = await AddItemImp().addAlterBarCode();
      s.fold(
          (falure) => setState(() {
                showAnimatedSnackBar(context, "Barcode Already Exists");
              }),
          (success) => setState(() {
                showSuccessAnimatedSnackBar(context, "Alternate Barcode Saved");
              }));
    }
  }
}
