import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/routes_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/core/util/animated_snackBar.dart';
import 'package:net_world_international/core/util/arabic_transileteration.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/category_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/department_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/second_category_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/supplier_master_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/tax_list.dart';
import 'package:net_world_international/infrastructure/login_api.dart';
import 'package:net_world_international/presentation/screens/home_screen.dart';
import 'package:net_world_international/presentation/screens/item_master.dart';
import 'package:net_world_international/presentation/screens/option_screen.dart';
import 'package:net_world_international/presentation/screens/profile_screen.dart';
import 'package:net_world_international/presentation/widget/curved_checkBox.dart';
import 'package:barcode_widget/barcode_widget.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  bool isActiceChecked = false;
  bool isNoneStockChecked = false;
  bool isCounterStockChecked = false;
  bool isBarCodeGen = false;
  bool isnextBarCode = false;
  bool isprevBarCode = false;
  bool onNextBarCode = false;
  bool isSaved = false;
  bool isprint = false;
  String? defCategory;
  String? secCategory;
  String? defDepartment;
  String? defSupplier;
  String? defTaxName;
  String? barcode;
  String? nextBarcode;
  String? preBarcode;
  TaxList? deftax;
  var cwT;
  int _selectedIndex = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const OptionScreen()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ItemMasterControllers.cleanControllers();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    BlocProvider.of<LoginBloc>(context).add(
      OptionPageEvent(),
    );
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                                "Item Master",
                                style: getMediumtStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: size.width * .3,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return const ItemMasterScreen();
                                  }));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colormanager.primary,
                                ),
                                child: const Text("View Items")),
                          ),
                        ],
                      ),
                      Text(
                        "Barcode",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ItemMasterControllers.barCodeController,
                                  decoration: InputDecoration(
                                    hintText: "Barcode",
                                    hintStyle: getRegularStyle(
                                        color: Colors.grey, fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colormanager.primary),
                                      // borderRadius: BorderRadius.circular(5)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 2, 76, 136)),
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
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      setState(() {
                                        isBarCodeGen = true;
                                        ItemMasterControllers.barCodeController2
                                            .clear();
                                        if (ItemMasterControllers
                                            .barCodeController.text.isEmpty) {
                                          ItemMasterControllers
                                              .barCodeController
                                              .text = state.barCode1 ?? '';
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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
                                                color: Colormanager.primary,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Material(
                              color: Colormanager.teritiory,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                splashColor: Colormanager.primary,
                                borderRadius: BorderRadius.circular(5),
                                onTap: () async {
                                  // await prevBarCode(ItemMasterControllers
                                  //     .barCodeController.text);
                                  ItemMasterControllers.barCodeController
                                      .clear();
                                  final barc = ItemMasterControllers
                                          .barCodeController2.text.isNotEmpty
                                      ? ItemMasterControllers
                                          .barCodeController2.text
                                      : '4321';
                                  BlocProvider.of<LoginBloc>(context).add(
                                    NextBarCodeEvent(
                                        selectedThrow: 'previous',
                                        barcode: barc),
                                  );
                                  setState(() {
                                    isBarCodeGen = true;
                                    onNextBarCode = true;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                      child: Icon(Icons.arrow_back,
                                          size: 22,
                                          color: Colormanager.primary)),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colormanager.teritiory,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              splashColor: Colormanager.primary,
                              borderRadius: BorderRadius.circular(5),
                              onTap: () async {
                                // await nextBarCode(
                                ItemMasterControllers.barCodeController.clear();
                                final barc = ItemMasterControllers
                                        .barCodeController2.text.isNotEmpty
                                    ? ItemMasterControllers
                                        .barCodeController2.text
                                    : '4321';
                                // print(barc);
                                BlocProvider.of<LoginBloc>(context).add(
                                  NextBarCodeEvent(
                                      selectedThrow: 'next', barcode: barc),
                                );
                                setState(() {
                                  isBarCodeGen = true;
                                  onNextBarCode = true;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  // color: Colormanager.teritiory,
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 22,
                                  color: Colormanager.primary,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is OptionPageState &&
                              isBarCodeGen == true) {
                            // if (ItemMasterControllers
                            //     .barCodeController.text.isEmpty) {
                            //   barcode = state.barCode1;
                            // }
                            // print(ItemMasterControllers.barCodeController.text);
                            // print("object");
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                ItemMasterControllers
                                        .barCodeController2.text.isEmpty
                                    ? BarcodeWidget(
                                        barcode: Barcode.code128(),
                                        data: ItemMasterControllers
                                            .barCodeController.text,
                                        // width: 100,
                                        height: 100,
                                      )
                                    : BarcodeWidget(
                                        barcode: Barcode.code128(),
                                        data: ItemMasterControllers
                                            .barCodeController2.text,
                                        // width: 100,
                                        height: 100,
                                      ),
                              ],
                            );
                          }
                          //  else if (state is OptionPageState &&
                          //     onNextBarCode == true) {
                          //   BarcodeWidget(
                          //     barcode: Barcode.code128(),
                          //     data:
                          //         ItemMasterControllers.barCodeController2.text,
                          //     // width: 100,
                          //     height: 100,
                          //   );
                          // }
                          return Container();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Name",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                            controller: ItemMasterControllers.nameController,
                            decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: getRegularStyle(
                                  color: Colors.grey, fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Colormanager.primary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 2, 76, 136)),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Short Name",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                            controller:
                                ItemMasterControllers.shortNameController,
                            decoration: InputDecoration(
                              hintText: "Short Name",
                              hintStyle: getRegularStyle(
                                  color: Colors.grey, fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Colormanager.primary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 2, 76, 136)),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Arabic Name",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                  keyboardType: TextInputType.none,
                                  controller:
                                      ItemMasterControllers.arabicController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colormanager.primary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 2, 76, 136)),
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Material(
                            color: Colormanager.teritiory,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              splashColor: Colormanager.primary,
                              borderRadius: BorderRadius.circular(5),
                              onTap: transiletrate,
                              child: Container(
                                width: 40,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:
                                    const Center(child: Icon(Icons.translate)),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Department",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is OptionPageState) {
                            return SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  // width: size.width * .44,
                                  decoration: BoxDecoration(
                                      color: Colormanager.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colormanager.primary)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<DepartmentList>(
                                      isExpanded: true,
                                      iconStyleData: const IconStyleData(),
                                      hint: Text("Select Department",
                                          style: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: 15)),
                                      items: state
                                          .itemGetConfig?.departmentList!
                                          .map((item) =>
                                              DropdownMenuItem<DepartmentList>(
                                                value: item,
                                                child: Text(item.name ?? '',
                                                    style: getRegularStyle(
                                                        color: Colormanager
                                                            .mainTextColor,
                                                        fontSize: 15)),
                                              ))
                                          .toList(),
                                      // value: defDepartment,
                                      onChanged: (value) {
                                        setState(() {
                                          defDepartment = value?.name as String;
                                        });
                                        ItemMasterControllers
                                            .departmentNameController
                                            .text = defDepartment ?? '';
                                        ItemMasterControllers
                                            .departmentController
                                            .text = value?.id.toString() ?? '';
                                      },

                                      customButton: defDepartment == null
                                          ? null
                                          : Row(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 15, 10, 15),
                                                    child: Text(
                                                        defDepartment ?? '',
                                                        style: getRegularStyle(
                                                            color: Colormanager
                                                                .textColor,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Category",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is OptionPageState) {
                            return SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  // width: size.width * .44,
                                  decoration: BoxDecoration(
                                      color: Colormanager.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colormanager.primary)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<CategoryList>(
                                      isExpanded: true,
                                      iconStyleData: const IconStyleData(),
                                      hint: Text("Select Category",
                                          style: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: 15)),
                                      items: state.itemGetConfig?.categoryList!
                                          .map((item) =>
                                              DropdownMenuItem<CategoryList>(
                                                value: item,
                                                child: Text(item.name ?? '',
                                                    style: getRegularStyle(
                                                        color: Colormanager
                                                            .mainTextColor,
                                                        fontSize: 15)),
                                              ))
                                          .toList(),
                                      // value: defCategory,
                                      onChanged: (value) {
                                        setState(() {
                                          defCategory = value?.name as String;
                                        });
                                        ItemMasterControllers
                                            .categoryNameController
                                            .text = defCategory ?? '';
                                        ItemMasterControllers.categoryController
                                            .text = value?.id.toString() ?? '';
                                      },

                                      customButton: defCategory == null
                                          ? null
                                          : Row(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 15, 10, 15),
                                                    child: Text(
                                                        defCategory ?? '',
                                                        style: getRegularStyle(
                                                            color: Colormanager
                                                                .textColor,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sub Category",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is OptionPageState) {
                            return SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  // width: size.width * .44,
                                  decoration: BoxDecoration(
                                      color: Colormanager.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colormanager.primary)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<SecondCategoryList>(
                                      isExpanded: true,
                                      iconStyleData: const IconStyleData(),
                                      hint: Text("Select Sub Category",
                                          style: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: 15)),
                                      items: state
                                          .itemGetConfig?.secondCategoryList!
                                          .map((item) => DropdownMenuItem<
                                                  SecondCategoryList>(
                                                value: item,
                                                child: Text(item.name ?? '',
                                                    style: getRegularStyle(
                                                        color: Colormanager
                                                            .mainTextColor,
                                                        fontSize: 15)),
                                              ))
                                          .toList(),
                                      // value: secCategory,
                                      onChanged: (value) {
                                        setState(() {
                                          secCategory = value?.name as String;
                                        });
                                        ItemMasterControllers
                                            .subCategoryNameController
                                            .text = secCategory ?? '';
                                        ItemMasterControllers
                                            .subCategoryController
                                            .text = value?.id.toString() ?? '';
                                      },

                                      customButton: secCategory == null
                                          ? null
                                          : Row(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 15, 10, 15),
                                                    child: Text(
                                                        secCategory ?? '',
                                                        style: getRegularStyle(
                                                            color: Colormanager
                                                                .textColor,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Supplier",
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 14),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is OptionPageState) {
                            return SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  // width: size.width * .44,
                                  decoration: BoxDecoration(
                                      color: Colormanager.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colormanager.primary)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<SupplierMasterList>(
                                      isExpanded: true,
                                      iconStyleData: const IconStyleData(),
                                      hint: Text("Select Supplier",
                                          style: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: 15)),
                                      items: state
                                          .itemGetConfig?.supplierMasterList!
                                          .map((item) => DropdownMenuItem<
                                                  SupplierMasterList>(
                                                value: item,
                                                child: Text(item.name ?? '',
                                                    style: getRegularStyle(
                                                        color: Colormanager
                                                            .mainTextColor,
                                                        fontSize: 15)),
                                              ))
                                          .toList(),
                                      // value: defSupplier,
                                      onChanged: (value) {
                                        setState(() {
                                          defSupplier = value?.name as String;
                                        });
                                        ItemMasterControllers
                                            .supplierNameController
                                            .text = defSupplier ?? '';
                                        ItemMasterControllers.supplierController
                                            .text = value?.id.toString() ?? '';
                                        ItemMasterControllers.remarksController
                                            .text = value?.remarks ?? '';
                                        ItemMasterControllers
                                            .supplierCodeController
                                            .text = value?.code ?? '';
                                      },

                                      customButton: defSupplier == null
                                          ? null
                                          : Row(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 15, 10, 15),
                                                    child: Text(
                                                        defSupplier ??
                                                            ItemMasterControllers
                                                                .supplierNameController
                                                                .text,
                                                        style: getRegularStyle(
                                                            color: Colormanager
                                                                .textColor,
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
                      const SizedBox(
                        height: 20,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        if (state is OptionPageState) {
                                          return SizedBox(
                                            width: size.width * .35,
                                            height: 40,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Container(
                                                // width: size.width * .44,
                                                decoration: BoxDecoration(
                                                    color: Colormanager.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colormanager
                                                            .primary)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<TaxList>(
                                                    isExpanded: true,
                                                    iconStyleData:
                                                        const IconStyleData(),
                                                    hint: Text("Vat",
                                                        style: getRegularStyle(
                                                            color: Colormanager
                                                                .white,
                                                            fontSize: 12)),
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
                                                      setState(() {
                                                        defTaxName = value
                                                            ?.taxName as String;
                                                        deftax = value;
                                                        ItemMasterCloneControllers
                                                            .cdefTaxRate
                                                            .text = deftax
                                                                ?.taxRate
                                                                .toString() ??
                                                            '';

                                                        ItemMasterCloneControllers
                                                            .cdefTaxId
                                                            .text = deftax
                                                                ?.taxId
                                                                .toString() ??
                                                            '';
                                                      });
                                                    },

                                                    customButton:
                                                        defTaxName == null
                                                            ? null
                                                            : Row(
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              10,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child: Text(
                                                                          defTaxName ??
                                                                              '',
                                                                          style: getRegularStyle(
                                                                              color: Colormanager.white,
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: size.width * .35,
                                      height: 40,
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
                                                  "Rack No",
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
                                                    ItemMasterControllers
                                                        .rackNoController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Shelf No",
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
                                            keyboardType: TextInputType.number,
                                            controller: ItemMasterControllers
                                                .shelfNoController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                            keyboardType: TextInputType.number,
                                            controller: ItemMasterControllers
                                                .costPriceController,
                                            onChanged: (value) {
                                              ItemMasterControllers
                                                  .cleanControllersOnCostChange();
                                              if (value.isEmpty ||
                                                  deftax == null) {
                                                showAnimatedSnackBar(
                                                    context, "Choose a vat");
                                                return;
                                              }
                                              if (value.isEmpty) return;

                                              double s = double.parse(value);
                                              cwT = (s +
                                                  (s / 100 * deftax?.taxRate));
                                              ItemMasterControllers
                                                  .costWithTaxController
                                                  .text = cwT.toString();
                                            },
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
                                              "Cost With Tax",
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
                                            keyboardType: TextInputType.number,
                                            controller: ItemMasterControllers
                                                .costWithTaxController,
                                            onChanged: (value) {
                                              if (value.isEmpty) return;
                                              double cot = double.parse(value);
                                              ItemMasterControllers
                                                  .costPriceController
                                                  .text = (cot /
                                                      (1 +
                                                          deftax?.taxRate /
                                                              100))
                                                  .toStringAsFixed(2);
                                            },
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
                                                  "Margin %",
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

                                              // width: size.width * .35,
                                              child: TextFormField(
                                                controller:
                                                    ItemMasterControllers
                                                        .marginPerController,
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  if (value.isEmpty) return;

                                                  double s =
                                                      double.parse(value);
                                                  double l = double.parse(
                                                      ItemMasterControllers
                                                          .costPriceController
                                                          .text);
                                                  final t = (l / 100 * s);
                                                  ItemMasterControllers
                                                          .marginController
                                                          .text =
                                                      t.toStringAsFixed(2);
                                                  final k = l + t;
                                                  ItemMasterControllers
                                                          .sellingPController
                                                          .text =
                                                      k.toStringAsFixed(2);
                                                  ItemMasterControllers
                                                      .sellingPriceWithTaxController
                                                      .text = (double.parse(
                                                              ItemMasterControllers
                                                                  .costWithTaxController
                                                                  .text) +
                                                          t)
                                                      .toStringAsFixed(2);
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Margin \$",
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
                                          child: Center(
                                            child: TextField(
                                              controller: ItemMasterControllers
                                                  .marginController,
                                              onChanged: (value) {
                                                if (value.isEmpty ||
                                                    ItemMasterControllers
                                                        .costPriceController
                                                        .text
                                                        .isEmpty) return;
                                                final margin =
                                                    double.parse(value);
                                                final cot = double.parse(
                                                    ItemMasterControllers
                                                        .costPriceController
                                                        .text);
                                                ItemMasterControllers
                                                        .marginPerController
                                                        .text =
                                                    ((margin / cot) * 100)
                                                        .toStringAsFixed(2);

                                                //
                                                double s = double.parse(
                                                    ItemMasterControllers
                                                        .marginPerController
                                                        .text);
                                                double l = double.parse(
                                                    ItemMasterControllers
                                                        .costPriceController
                                                        .text);
                                                final t = (l / 100 * s);
                                                // ItemMasterControllers
                                                //     .marginController
                                                //     .text = t.toString();
                                                final k = l + t;
                                                ItemMasterControllers
                                                        .sellingPController
                                                        .text =
                                                    k.toStringAsFixed(2);
                                                ItemMasterControllers
                                                    .sellingPriceWithTaxController
                                                    .text = (double.parse(
                                                            ItemMasterControllers
                                                                .costWithTaxController
                                                                .text) +
                                                        t)
                                                    .toStringAsFixed(2);
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
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
                                            controller: ItemMasterControllers
                                                .sellingPController,
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
                                              "Selling With Tax",
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
                                            controller: ItemMasterControllers
                                                .sellingPriceWithTaxController,
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 3),
                                            child: CurvedCheckbox(
                                              value: isActiceChecked,
                                              onChanged: (value) {
                                                setState(() {
                                                  isActiceChecked = value;
                                                  isNoneStockChecked = false;
                                                  isCounterStockChecked = false;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            "Active",
                                            style: getRegularStyle(
                                                color: Colormanager.textColor,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 3),
                                            child: CurvedCheckbox(
                                              value: isNoneStockChecked,
                                              onChanged: (value) {
                                                setState(() {
                                                  isNoneStockChecked = value;
                                                  isActiceChecked = false;
                                                  isCounterStockChecked = false;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            "None Stock ",
                                            style: getRegularStyle(
                                                color: Colormanager.textColor,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 3),
                                            child: CurvedCheckbox(
                                              value: isCounterStockChecked,
                                              onChanged: (value) {
                                                setState(() {
                                                  isCounterStockChecked = value;
                                                  isActiceChecked = false;
                                                  isNoneStockChecked = false;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            "Counter Stock",
                                            style: getRegularStyle(
                                                color: Colormanager.textColor,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Material(
                                      color: Colormanager.teritiory,
                                      borderRadius: BorderRadius.circular(5),
                                      child: InkWell(
                                        splashColor: Colormanager.primary,
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: saveItemMasterdata,
                                        child: Container(
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            // border: Border.all(
                                            //     color: Colormanager.primary),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // color: Colormanager.teritiory,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Save",
                                            style: getRegularStyle(
                                                color: Colormanager.primary,
                                                fontSize: 10),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Material(
                                      color: Colormanager.teritiory,
                                      borderRadius: BorderRadius.circular(5),
                                      child: InkWell(
                                        splashColor: Colormanager.primary,
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          ItemMasterControllers
                                              .cleanControllers();
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Clear",
                                            style: getRegularStyle(
                                                color: Colormanager.primary,
                                                fontSize: 10),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  isSaved
                                      ? const SizedBox(
                                          width: 5,
                                        )
                                      : Container(),
                                  isSaved
                                      ? BlocBuilder<LoginBloc, LoginState>(
                                          builder: (context, state) {
                                            if (state is OptionPageState) {
                                              return Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    ItemMasterCloneControllers
                                                        .clone();

                                                    setState(() {
                                                      defSupplier =
                                                          ItemMasterControllers
                                                              .supplierNameController
                                                              .text;
                                                      defDepartment =
                                                          ItemMasterControllers
                                                              .departmentNameController
                                                              .text;
                                                      defCategory =
                                                          ItemMasterControllers
                                                              .categoryNameController
                                                              .text;
                                                      secCategory =
                                                          ItemMasterControllers
                                                              .subCategoryNameController
                                                              .text;
                                                      isBarCodeGen = true;
                                                    });
                                                    ItemMasterControllers
                                                            .barCodeController
                                                            .text =
                                                        state.barCode1 ?? '';
                                                  },
                                                  child: Container(
                                                    width: 70,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colormanager
                                                          .teritiory,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Clone",
                                                      style: getRegularStyle(
                                                          color: Colormanager
                                                              .primary,
                                                          fontSize: 10),
                                                    )),
                                                  ),
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        )
                                      : Container(),
                                  isSaved
                                      ? const SizedBox(
                                          width: 5,
                                        )
                                      : Container(),
                                  isSaved
                                      ? Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, Routes.viewPage);
                                            },
                                            child: Container(
                                              width: 70,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colormanager.teritiory,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "View",
                                                style: getRegularStyle(
                                                    color: Colormanager.primary,
                                                    fontSize: 10),
                                              )),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  isSaved
                                      ? const SizedBox(
                                          width: 5,
                                        )
                                      : Container(),
                                  isSaved
                                      ? Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isprint = !isprint;
                                              });
                                            },
                                            child: Container(
                                              width: 70,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colormanager.teritiory,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Print",
                                                style: getRegularStyle(
                                                    color: Colormanager.primary,
                                                    fontSize: 10),
                                              )),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isprint
                          ? Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                            color: Colors.black,
                                                            fontSize: 10),
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
                                                        decoration:
                                                            InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.5),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colormanager
                                                                .primary),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    2,
                                                                    76,
                                                                    136)),
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
                                          style: getRegularStyle(
                                              color: Colors.black,
                                              fontSize: 10),
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
                                          decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.5),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colormanager.primary),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 2, 76, 136)),
                                        ),
                                      )),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        if (state is OptionPageState) {
                                          return BarcodeWidget(
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
                                                        "Price",
                                                        style: getRegularStyle(
                                                            color: Colors.black,
                                                            fontSize: 10),
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
                                                        decoration:
                                                            InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.5),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colormanager
                                                                .primary),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    2,
                                                                    76,
                                                                    136)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Price Quantity",
                                                    style: getRegularStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
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
                                                    decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.5),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colormanager
                                                            .primary),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 2, 76, 136)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 70,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colormanager.teritiory,
                                              border: Border.all(
                                                  color: Colormanager.primary),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Item Print",
                                              style: getRegularStyle(
                                                  color: Colormanager.primary,
                                                  fontSize: 10),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colormanager.primary),
                                              color: Colormanager.teritiory,
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Shelf Print",
                                              style: getRegularStyle(
                                                  color: Colormanager.primary,
                                                  fontSize: 10),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colormanager.primary),
                                              color: Colormanager.teritiory,
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Jewellery",
                                              style: getRegularStyle(
                                                  color: Colormanager.primary,
                                                  fontSize: 10),
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  saveItemMasterdata() async {
    if (ItemMasterControllers.barCodeController.text.isEmpty &&
        ItemMasterControllers.barCodeController2.text.isEmpty) {
      showAnimatedSnackBar(context, "Generate a BarCode");
    } else if (ItemMasterControllers.nameController.text.isEmpty) {
      print(ItemMasterControllers.barCodeController2.text);
      showAnimatedSnackBar(context, "Enter Your Name");
    } else if (ItemMasterControllers.shortNameController.text.isEmpty) {
      showAnimatedSnackBar(context, "Enter Your Short Name");
    } else if (ItemMasterControllers.arabicController.text.isEmpty) {
      showAnimatedSnackBar(context, "Generate Your Arabic Name");
    } else if (ItemMasterControllers.departmentController.text.isEmpty) {
      showAnimatedSnackBar(context, "Select a Department");
    } else if (ItemMasterControllers.categoryController.text.isEmpty) {
      showAnimatedSnackBar(context, "Select a Category");
    } else if (ItemMasterControllers.subCategoryController.text.isEmpty) {
      showAnimatedSnackBar(context, "Select a sub Category");
    } else if (ItemMasterControllers.supplierCodeController.text.isEmpty) {
      showAnimatedSnackBar(context, "Select a Supplier");
    } else if (ItemMasterControllers.costPriceController.text.isEmpty) {
      showAnimatedSnackBar(context, "Enter a Cost");
    } else if (ItemMasterControllers.sellingPController.text.isEmpty) {
      showAnimatedSnackBar(context, "Selling Price is Mandatory");
    } else {
      ItemMasterControllers.activeController.text = isActiceChecked.toString();
      ItemMasterControllers.nonStockController.text =
          isNoneStockChecked.toString();
      ItemMasterControllers.counterStockController.text =
          isCounterStockChecked.toString();
      // ItemMasterControllers.barCodeController.text = barcode ?? '';
      // print(ItemMasterControllers.barCodeController.text);
      // return;

      final s = await LoginImp().addToItemMaster();

      s.fold((falure) {
        return setState(() {
          showAnimatedSnackBar(context, "Barcode Already Exists");
        });
      }, (success) {
        BlocProvider.of<LoginBloc>(context).add(
          OptionPageEvent(),
        );
        ItemMasterCloneControllers.save();

        defSupplier = null;
        defCategory = null;
        secCategory = null;
        defDepartment = null;
        isSaved = true;
        return setState(() {
          showSuccessAnimatedSnackBar(context, "Item Master Saved");
        });
      });
    }
  }
}
