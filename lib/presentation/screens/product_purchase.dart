import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/core/util/animated_snackbar.dart';
import 'package:net_world_international/core/util/check_dep_name.dart';
import 'package:net_world_international/core/util/global_list.dart';
import 'package:net_world_international/domain/db/db_supplier.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/supplier_master_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/tax_list.dart';
import 'package:net_world_international/presentation/screens/home_screen.dart';
import 'package:net_world_international/presentation/screens/option_screen.dart';
import 'package:net_world_international/presentation/screens/profile_screen.dart';
import 'package:net_world_international/presentation/widget/pp_decoration.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sqflite/sqflite.dart';

class ProductPurchasePage extends StatefulWidget {
  const ProductPurchasePage({super.key});

  @override
  State<ProductPurchasePage> createState() => _ProductPurchasePageState();
}

class _ProductPurchasePageState extends State<ProductPurchasePage> {
  int _selectedIndex = 2;
  bool isBarcodeSearching = false;
  bool isSupListLoading = false;
  List<DbSupplier> supplierDetails = [];
  TaxList? deftax;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Database? database;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const OptionScreen()
  ];

  @override
  void initState() {
    super.initState();
    print(GlobalList().taxList);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      supplierDetails.clear();

      database = await openDatabase('my_database.db');

      //!
      const int batchSize = 30000; // Adjust the batch size as needed
      // final List<Map<String, dynamic>> rows =
      //     await database!.query('PTempPurchaseMaster2');

      // for (final row in rows) {
      //   print(row);
      // }
      setState(() {
        isSupListLoading = true;
      });

      //!
      // const int batchSize = 30000; // Adjust the batch size as needed

// Fetch the rows in batches
      for (int offset = 0;; offset += batchSize) {
        final List<Map<String, dynamic>> batchData = await database!.query(
          'MyTable',
          where: 'tableName = ?',
          whereArgs: ['PSupplierMaster'],
          limit: batchSize,
          offset: offset,
        );

        if (batchData.isEmpty) {
          break; // Exit the loop if no more rows are returned
        }
        // Process the fetched rows here
        for (final row in batchData) {
          if (row.containsKey('rowJson')) {
            final rowData = jsonDecode(row['rowJson']);
            final supplier = DbSupplier.fromJson(rowData);
            supplierDetails.add(supplier);
            setState(() {
              isSupListLoading = false;
            });
          }
        }
      }
    });
  }

  searchBarcode() async {
    const int batchSize = 30000; // Adjust the batch size as needed
    bool isBarcodeFound = false;
    setState(() {
      isBarcodeSearching = true;
    });

// Fetch the rows in batches
    for (int offset = 0;; offset += batchSize) {
      final List<Map<String, dynamic>> batchData = await database!.query(
        'MyTable',
        where: 'tableName = ?',
        whereArgs: ['PItemMaster'],
        limit: batchSize,
        offset: offset,
      );

      if (batchData.isEmpty) {
        break; // Exit the loop if no more rows are returned
      }

      // Process the fetched rows here
      for (final row in batchData) {
        if (row.containsKey('rowJson')) {
          final rowData = jsonDecode(row['rowJson']);

          if (rowData is Map &&
              rowData.containsKey('Barcode') &&
              rowData['Barcode'] ==
                  ProductPurchaseController.barCodeContorller.text) {
            print(rowData);
            ProductPurchaseController.nameController.text = rowData['Name'];
            ProductPurchaseController.selling.text =
                rowData['SellingPrice'].toString();
            ProductPurchaseController.costPrice.text =
                rowData['CostPrice'].toString();
            ProductPurchaseController.foc.text = rowData['FOCitem'].toString();
            ProductPurchaseController.discount.text =
                rowData['Discount'].toString();
            ProductPurchaseController.taxId.text = rowData['TaxId'].toString();
            deftax = getTaxListById(rowData['TaxId']);
            ProductPurchaseController.taxNameCon.text = deftax?.taxName ?? '';
            ProductPurchaseController.total.text =
                rowData['SellingPrice'].toString();
            isBarcodeFound = true;
            setState(() {
              isBarcodeSearching = false;
            });
          }
        }
      }
    }

    if (!isBarcodeFound) {
      print("empty");
      showAnimatedSnackBar(context, "No Barcode Found");
      setState(() {
        isBarcodeSearching = false;
      });
    }
  }

  onTaxSelect(value) {
    setState(() {
      ProductPurchaseController.taxNameCon.text = value?.taxName as String;
      deftax = value;
      // ItemMasterCloneControllers.cdefTaxRate.text =
      //     deftax?.taxRate.toString() ?? '';

      // ItemMasterCloneControllers.cdefTaxId.text =
      //     deftax?.taxId.toString() ?? '';
    });
    // if (ItemMasterControllers.costPriceController.text.isNotEmpty) {
    //   onCostChange(ItemMasterControllers.costPriceController.text);
    // }
    // if (ItemMasterControllers.marginController.text.isNotEmpty) {
    //   onMarginCostChanged(ItemMasterControllers.marginController.text);
    // }
    // if (ItemMasterControllers.costWithTaxController.text.isNotEmpty) {
    //   onCostWithTaxChanged(ItemMasterControllers.costWithTaxController.text);
    // }
    // if (ItemMasterControllers.marginPerController.text.isNotEmpty) {
    //   onMarginPerChanged(ItemMasterControllers.marginPerController.text);
    // }
  }

  searchSupplier() async {
    const int batchSize = 30000; // Adjust the batch size as needed
    bool isSupplierFound = false;
    setState(() {
      isSupListLoading = true;
    });

// Fetch the rows in batches
    for (int offset = 0;; offset += batchSize) {
      final List<Map<String, dynamic>> batchData = await database!.query(
        'MyTable',
        where: 'tableName = ?',
        whereArgs: ['PSupplierMaster'],
        limit: batchSize,
        offset: offset,
      );

      if (batchData.isEmpty) {
        break; // Exit the loop if no more rows are returned
      }

      // Process the fetched rows here
      for (final row in batchData) {
        if (row.containsKey('rowJson')) {
          final rowData = jsonDecode(row['rowJson']);
          if (rowData is Map &&
              rowData.containsKey('code') &&
              rowData['code'] == ProductPurchaseController.supCode.text) {
            print(rowData);
            ProductPurchaseController.supName.text = rowData['Name'];
            // ProductPurchaseController.selling.text =
            //     rowData['SellingPrice'].toString();
            isSupplierFound = true;
            setState(() {
              isSupListLoading = false;
            });
          }
        }
      }
    }

    if (!isSupplierFound) {
      print("empty");
      showAnimatedSnackBar(context, "No Supplier Found");
      setState(() {
        isSupListLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
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
          if (index == 2) {
            BlocProvider.of<LoginBloc>(context).add(
              OptionPageEvent(),
            );
            Navigator.pop(context);
          }
        },
        letIndexChange: (index) => true,
      ),
      body: _selectedIndex != 2
          ? _screens[_selectedIndex]
          : SafeArea(
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: InkWell(
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
                              "Product Purchase",
                              style: getMediumtStyle(
                                  color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                          // width: 40,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
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
                                          keyboardType: TextInputType.number,
                                          controller:
                                              ProductPurchaseController.supCode,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Sup Code",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        // width: size.width * .44,
                                        decoration: BoxDecoration(
                                            color: Colormanager.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colormanager.primary)),
                                        child: DropdownButtonHideUnderline(
                                          child: isSupListLoading
                                              ? const Center(
                                                  child: SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child:
                                                          CircularProgressIndicator()),
                                                )
                                              : DropdownButton2<DbSupplier>(
                                                  isExpanded: true,
                                                  iconStyleData:
                                                      const IconStyleData(),
                                                  hint: Text("Select Supplier",
                                                      style: getRegularStyle(
                                                          color: Colormanager
                                                              .mainTextColor,
                                                          fontSize: 12)),
                                                  items: supplierDetails
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              DbSupplier>(
                                                            value: item,
                                                            child: Text(
                                                                item.name,
                                                                style: getRegularStyle(
                                                                    color: Colormanager
                                                                        .mainTextColor,
                                                                    fontSize:
                                                                        15)),
                                                          ))
                                                      .toList(),
                                                  // value: defSupplier,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      ProductPurchaseController
                                                              .supName.text =
                                                          value?.name as String;
                                                    });
                                                    ProductPurchaseController
                                                            .supCode.text =
                                                        value?.code as String;
                                                    // ItemMasterControllers
                                                    //     .supplierNameController
                                                    //     .text = defSupplier ?? '';
                                                    // ItemMasterControllers
                                                    //         .supplierController
                                                    //         .text =
                                                    //     value?.id.toString() ??
                                                    //         '';
                                                    // ItemMasterControllers
                                                    //         .remarksController
                                                    //         .text =
                                                    //     value?.remarks ?? '';
                                                    // ItemMasterControllers
                                                    //     .supplierCodeController
                                                    //     .text = value
                                                    //         ?.code ??
                                                    //     '';
                                                  },

                                                  customButton:
                                                      ProductPurchaseController
                                                              .supName
                                                              .text
                                                              .isEmpty
                                                          ? null
                                                          : Row(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            15,
                                                                            10,
                                                                            15),
                                                                    child: Text(
                                                                      ProductPurchaseController
                                                                          .supName
                                                                          .text,
                                                                      style:
                                                                          getRegularStyle(
                                                                        color: Colormanager
                                                                            .textColor,
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                      maxLines:
                                                                          1, // Specify the maximum number of lines
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis, // Handle overflow with ellipsis
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                  //This to clear the search value when you close the menu
                                                  // onMenuStateChange: (isOpen) {
                                                  //   if (!isOpen) {
                                                  //     AddressEditControllers
                                                  //         .searchController
                                                  //         .clear();
                                                  //   }
                                                  // }
                                                ),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5,
                                          ),
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
                                            keyboardType: TextInputType.number,
                                            controller:
                                                ProductPurchaseController.invNo,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Inv No",
                                                hintStyle: getRegularStyle(
                                                    color: Colormanager
                                                        .mainTextColor,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5,
                                          ),
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
                                            keyboardType: TextInputType.number,
                                            controller:
                                                ProductPurchaseController
                                                    .invDate,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Inv Date",
                                                hintStyle: getRegularStyle(
                                                    color: Colormanager
                                                        .mainTextColor,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5,
                                          ),
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
                                            keyboardType: TextInputType.number,
                                            controller:
                                                ProductPurchaseController
                                                    .invTotal,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Inv Total",
                                                hintStyle: getRegularStyle(
                                                    color: Colormanager
                                                        .mainTextColor,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: searchSupplier,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colormanager.secondary,
                              ),
                              width: 70,
                              height: 110,
                              child: isSupListLoading
                                  ? const Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Center(
                                      child: Text("Enter",
                                          style: getRegularStyle(
                                              color: Colormanager.mainTextColor,
                                              fontSize: 12)),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [],
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      //   child: Row(
                      //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       // Text(
                      //       //   " Id",
                      //       //   style: getRegularStyle(
                      //       //     color: Colormanager.mainTextColor,
                      //       //   ),
                      //       // ),
                      //       SizedBox(
                      //         width: w * .4,
                      //         child: Text(
                      //           "Supplier",
                      //           style: getRegularStyle(
                      //             color: Colormanager.mainTextColor,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: w * .15,
                      //         child: Text(
                      //           "Date",
                      //           style: getRegularStyle(
                      //             color: Colormanager.mainTextColor,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: w * .15,
                      //         child: Text(
                      //           "Qty",
                      //           style: getRegularStyle(
                      //             color: Colormanager.mainTextColor,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: w * .15,
                      //         child: Text(
                      //           "Rate",
                      //           style: getRegularStyle(
                      //             color: Colormanager.mainTextColor,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 150,
                      //   child: BlocBuilder<LoginBloc, LoginState>(
                      //     builder: (context, state) {
                      //       if (state is OptionPageState) {
                      //         final cuState = state;
                      //         return ListView.builder(
                      //           shrinkWrap: true,
                      //           itemBuilder: (ctx, index) {
                      //             return Material(
                      //               color: (index % 2) != 0
                      //                   ? Colormanager.white
                      //                   : Colormanager.teritiory,
                      //               borderRadius: BorderRadius.circular(5),
                      //               child: InkWell(
                      //                 splashColor: Colormanager.primary,
                      //                 borderRadius: BorderRadius.circular(5),
                      //                 onTap: () async {},
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(5),
                      //                   ),
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.fromLTRB(
                      //                         15, 15, 0, 15),
                      //                     child: Row(
                      //                       // mainAxisAlignment:
                      //                       //     MainAxisAlignment.spaceBetween,
                      //                       children: [
                      //                         // Text(
                      //                         //   // "${index + 1}",
                      //                         //   state.getItems?.items?[index].id
                      //                         //           .toString() ??
                      //                         //       '',
                      //                         //   style: getRegularStyle(
                      //                         //       color: Colors.black,
                      //                         //       fontSize: 10),
                      //                         // ),
                      //                         SizedBox(
                      //                           width: w * .4,
                      //                           child: Text(
                      //                             state.getItems?.items?[index]
                      //                                     .name ??
                      //                                 '',
                      //                             style: getRegularStyle(
                      //                                 color: Colors.black,
                      //                                 fontSize: 10),
                      //                           ),
                      //                         ),
                      //                         SizedBox(
                      //                           width: w * .15,
                      //                           child: Text(
                      //                             "s",
                      //                             style: getRegularStyle(
                      //                                 color: Colors.black,
                      //                                 fontSize: 10),
                      //                           ),
                      //                         ),
                      //                         SizedBox(
                      //                           width: w * .15,
                      //                           child: Text(
                      //                             state.getItems?.items?[index]
                      //                                     .costPrice
                      //                                     .toString() ??
                      //                                 '',
                      //                             style: getRegularStyle(
                      //                                 color: Colors.black,
                      //                                 fontSize: 10),
                      //                           ),
                      //                         ),
                      //                         SizedBox(
                      //                           width: w * .15,
                      //                           child: Text(
                      //                             state.getItems?.items?[index]
                      //                                     .sellingPrice
                      //                                     .toString() ??
                      //                                 '',
                      //                             style: getRegularStyle(
                      //                                 color: Colors.black,
                      //                                 fontSize: 10),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //           itemCount: state.getItems?.items?.length,
                      //         );
                      //       }
                      //       return Container();
                      //     },
                      //   ),
                      // ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: ProductPurchaseController
                                            .barCodeContorller,
                                        decoration: InputDecoration(
                                          hintText: "Barcode",
                                          hintStyle: getRegularStyle(
                                              color: Colormanager.mainTextColor,
                                              fontSize: 12),
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
                                                color: Colormanager.primary),
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: InkWell(
                                    onTap: searchBarcode,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colormanager.secondary,
                                      ),
                                      width: 40,
                                      height: 50,
                                      child: Center(
                                          child: isBarcodeSearching
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator())
                                              : const Icon(Icons.search)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 110,
                                  child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          ProductPurchaseController.selling,
                                      decoration: InputDecoration(
                                        hintText: "Selling",
                                        hintStyle: getRegularStyle(
                                            color: Colormanager.mainTextColor,
                                            fontSize: 12),
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
                                              color: Colormanager.primary),
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
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    // width: size.width * .35,
                                    child: TextField(
                                        controller: ProductPurchaseController
                                            .nameController,
                                        decoration: InputDecoration(
                                          hintText: "Name",
                                          hintStyle: getRegularStyle(
                                              color: Colormanager.mainTextColor,
                                              fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colormanager.primary),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 2, 76, 136)),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: ItemMasterControllers
                                              .shelfNoController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Qty",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller:
                                              ProductPurchaseController.foc,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Foc",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    if (state is OptionPageState) {
                                      return SizedBox(
                                        width: size.width * .25,
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Container(
                                            // width: size.width * .44,
                                            decoration: BoxDecoration(
                                                color: Colormanager.primary,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color:
                                                        Colormanager.primary)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<TaxList>(
                                                isExpanded: true,
                                                iconStyleData:
                                                    const IconStyleData(),
                                                hint: Text("Vat",
                                                    style: getRegularStyle(
                                                        color:
                                                            Colormanager.white,
                                                        fontSize: 10)),
                                                items: state
                                                    .itemGetConfig?.taxList!
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            TaxList>(
                                                          value: item,
                                                          child: Text(
                                                              item.taxName ??
                                                                  '',
                                                              style: getRegularStyle(
                                                                  color: Colormanager
                                                                      .mainTextColor,
                                                                  fontSize:
                                                                      12)),
                                                        ))
                                                    .toList(),
                                                // value: defTaxName,
                                                onChanged: (value) {
                                                  onTaxSelect(value);
                                                },

                                                customButton:
                                                    ProductPurchaseController
                                                            .taxNameCon
                                                            .text
                                                            .isEmpty
                                                        ? null
                                                        : Row(
                                                            children: [
                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                      ProductPurchaseController
                                                                          .taxNameCon
                                                                          .text,
                                                                      style: getRegularStyle(
                                                                          color: Colormanager
                                                                              .white,
                                                                          fontSize:
                                                                              10)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                //This to clear the search value when you close the menu
                                                // onMenuStateChange: (isOpen) {
                                                //   if (!isOpen) {
                                                //     AddressEditControllers
                                                //         .searchController
                                                //         .clear();
                                                //   }
                                                // }
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Container(
                                    width: size.width * .1,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colormanager.primary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 3, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            deftax?.taxRate.toString() ??
                                                'Unit',
                                            style: getRegularStyle(
                                                color: Colormanager.white,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: ProductPurchaseController
                                              .costPrice,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Rate",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: ItemMasterControllers
                                              .shelfNoController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Rate+Tax",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: ProductPurchaseController
                                              .discount,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Discount",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller:
                                              ProductPurchaseController.total,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Total",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (ProductPurchaseController
                                      .supName.text.isEmpty) {
                                    showAnimatedSnackBar(
                                        context, "Select A Supplier");
                                  } else if (ProductPurchaseController
                                      .nameController.text.isEmpty) {
                                    showAnimatedSnackBar(
                                        context, "Select A Product");
                                  } else {
                                    //     'DROP TABLE IF EXISTS PTempPurchaseMaster2');
                                    // return;
                                    final List<Map<String, dynamic>> result =
                                        await database!.rawQuery(
                                      "SELECT name FROM sqlite_master WHERE type='table' AND name='PTempPurchaseMaster2'",
                                    );

                                    if (result.isEmpty) {
                                      await database!.execute(
                                        'CREATE TABLE PTempPurchaseMaster2 ('
                                        'id INTEGER PRIMARY KEY, '
                                        'Total INTEGER, '
                                        'SupplierId INTEGER, '
                                        'VoucherNo INTEGER, '
                                        'CCode INTEGER, '
                                        'CurrencyId INTEGER, '
                                        'ExchangeRate INTEGER, '
                                        'PurTotal INTEGER, '
                                        'PurDiscount INTEGER, '
                                        'PurFreight INTEGER'
                                        ')',
                                      );
                                    }

                                    await database!.transaction((txn) async {
                                      await txn.rawInsert(
                                        'INSERT INTO PTempPurchaseMaster2(Total,SupplierId,VoucherNo,CCode,CurrencyId,ExchangeRate,PurTotal,PurDiscount,PurFreight) VALUES(${ProductPurchaseController.total.text},${ProductPurchaseController.supCode.text},545,7,0,0,${ProductPurchaseController.total.text},${ProductPurchaseController.discount.text},0)',
                                      );
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    showSuccessAnimatedSnackBar(
                                        context, "Product Purchased");
                                    Navigator.pop(context);
                                  }
                                  // await database!.execute(
                                },
                                child: const Text("Purchase Product"))
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Column(children: [
                    //   Padding(
                    //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: const [],
                    //       )),
                    //   Padding(
                    //     padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                    //     child: Row(
                    //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         // Text(
                    //         //   " Id",
                    //         //   style: getRegularStyle(
                    //         //     color: Colormanager.mainTextColor,
                    //         //   ),
                    //         // ),
                    //         SizedBox(
                    //           width: w * .4,
                    //           child: Text(
                    //             "Barcode",
                    //             style: getRegularStyle(
                    //               color: Colormanager.mainTextColor,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: w * .15,
                    //           child: Text(
                    //             "Name",
                    //             style: getRegularStyle(
                    //               color: Colormanager.mainTextColor,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: w * .15,
                    //           child: Text(
                    //             "Qty",
                    //             style: getRegularStyle(
                    //               color: Colormanager.mainTextColor,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: w * .15,
                    //           child: Text(
                    //             "Rate",
                    //             style: getRegularStyle(
                    //               color: Colormanager.mainTextColor,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     height: 150,
                    //     child: BlocBuilder<LoginBloc, LoginState>(
                    //       builder: (context, state) {
                    //         if (state is OptionPageState) {
                    //           final cuState = state;
                    //           return ListView.builder(
                    //             shrinkWrap: true,
                    //             itemBuilder: (ctx, index) {
                    //               return Material(
                    //                 color: (index % 2) != 0
                    //                     ? Colormanager.white
                    //                     : Colormanager.teritiory,
                    //                 borderRadius: BorderRadius.circular(5),
                    //                 child: InkWell(
                    //                   splashColor: Colormanager.primary,
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   onTap: () async {},
                    //                   child: Container(
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(5),
                    //                     ),
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.fromLTRB(
                    //                           15, 15, 0, 15),
                    //                       child: Row(
                    //                         // mainAxisAlignment:
                    //                         //     MainAxisAlignment.spaceBetween,
                    //                         children: [
                    //                           // Text(
                    //                           //   // "${index + 1}",
                    //                           //   state.getItems?.items?[index].id
                    //                           //           .toString() ??
                    //                           //       '',
                    //                           //   style: getRegularStyle(
                    //                           //       color: Colors.black,
                    //                           //       fontSize: 10),
                    //                           // ),
                    //                           SizedBox(
                    //                             width: w * .4,
                    //                             child: Text(
                    //                               state.getItems?.items?[index]
                    //                                       .name ??
                    //                                   '',
                    //                               style: getRegularStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 10),
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             width: w * .15,
                    //                             child: Text(
                    //                               "s",
                    //                               style: getRegularStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 10),
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             width: w * .15,
                    //                             child: Text(
                    //                               state.getItems?.items?[index]
                    //                                       .costPrice
                    //                                       .toString() ??
                    //                                   '',
                    //                               style: getRegularStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 10),
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             width: w * .15,
                    //                             child: Text(
                    //                               state.getItems?.items?[index]
                    //                                       .sellingPrice
                    //                                       .toString() ??
                    //                                   '',
                    //                               style: getRegularStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 10),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    //             itemCount: state.getItems?.items?.length,
                    //           );
                    //         }
                    //         return Container();
                    //       },
                    //     ),
                    //   ),
                    // ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
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
                                Text(
                                  "Search Purchase Invoice",
                                  style: getSemiBoldStyle(
                                      color: Colormanager.mainTextColor,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: ItemMasterControllers
                                            .barCodeController,
                                        decoration: InputDecoration(
                                          hintText: "Sup Code",
                                          hintStyle: getRegularStyle(
                                              color: Colormanager.mainTextColor,
                                              fontSize: 12),
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
                                                color: Colormanager.primary),
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
                                Expanded(
                                  child: BlocBuilder<LoginBloc, LoginState>(
                                    builder: (context, state) {
                                      if (state is OptionPageState) {
                                        return SizedBox(
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Container(
                                              // width: size.width * .44,
                                              decoration: BoxDecoration(
                                                  color: Colormanager.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colormanager
                                                          .primary)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<
                                                    SupplierMasterList>(
                                                  isExpanded: true,
                                                  iconStyleData:
                                                      const IconStyleData(),
                                                  hint: Text("Select Supplier",
                                                      style: getRegularStyle(
                                                          color: Colormanager
                                                              .mainTextColor,
                                                          fontSize: 12)),
                                                  items: state.itemGetConfig
                                                      ?.supplierMasterList!
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              SupplierMasterList>(
                                                            value: item,
                                                            child: Text(
                                                                item.name ?? '',
                                                                style: getRegularStyle(
                                                                    color: Colormanager
                                                                        .mainTextColor,
                                                                    fontSize:
                                                                        15)),
                                                          ))
                                                      .toList(),
                                                  // value: defSupplier,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      ItemMasterControllers
                                                              .supplierNameController
                                                              .text =
                                                          value?.name as String;
                                                    });
                                                    // ItemMasterControllers
                                                    //     .supplierNameController
                                                    //     .text = defSupplier ?? '';
                                                    ItemMasterControllers
                                                            .supplierController
                                                            .text =
                                                        value?.id.toString() ??
                                                            '';
                                                    ItemMasterControllers
                                                            .remarksController
                                                            .text =
                                                        value?.remarks ?? '';
                                                    ItemMasterControllers
                                                        .supplierCodeController
                                                        .text = value
                                                            ?.code ??
                                                        '';
                                                  },

                                                  customButton:
                                                      ItemMasterControllers
                                                              .supplierNameController
                                                              .text
                                                              .isEmpty
                                                          ? null
                                                          : Row(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            15,
                                                                            10,
                                                                            15),
                                                                    child: Text(
                                                                        ItemMasterControllers
                                                                            .supplierNameController
                                                                            .text,
                                                                        style: getRegularStyle(
                                                                            color:
                                                                                Colormanager.textColor,
                                                                            fontSize: 12)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                  //This to clear the search value when you close the menu
                                                  // onMenuStateChange: (isOpen) {
                                                  //   if (!isOpen) {
                                                  //     AddressEditControllers
                                                  //         .searchController
                                                  //         .clear();
                                                  //   }
                                                  // }
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: ItemMasterControllers
                                              .shelfNoController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Inv No",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        decoration: buildPpDecoration(),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: ItemMasterControllers
                                              .shelfNoController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Inv Date",
                                              hintStyle: getRegularStyle(
                                                  color: Colormanager
                                                      .mainTextColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      width: size.width * .35,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colormanager.primary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 3, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              // deftax?.taxRate.toString() ??
                                              'Unit',
                                              style: getRegularStyle(
                                                  color: Colormanager.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
