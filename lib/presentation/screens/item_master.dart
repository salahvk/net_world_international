import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/routes_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:net_world_international/core/util/check_dep_name.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/department_list.dart';
import 'package:net_world_international/infrastructure/item_imp.dart';
import 'package:net_world_international/presentation/screens/home_screen.dart';
import 'package:net_world_international/presentation/screens/option_screen.dart';
import 'package:net_world_international/presentation/screens/profile_screen.dart';

class ItemMasterScreen extends StatefulWidget {
  const ItemMasterScreen({super.key});

  @override
  State<ItemMasterScreen> createState() => _ItemMasterScreenState();
}

class _ItemMasterScreenState extends State<ItemMasterScreen> {
  int _selectedIndex = 2;
  int _currentPage = 1;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const OptionScreen()
  ];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(
      OptionPageEvent(),
    );
    print("initstate");
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
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
              Navigator.pop(context);
            }
          },
          letIndexChange: (index) => true,
        ),
        body: _selectedIndex != 2
            ? _screens[_selectedIndex]
            : BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                if (state is OptionPageState) {
                  return SafeArea(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [],
                            )),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   " Id",
                                  //   style: getRegularStyle(
                                  //     color: Colormanager.mainTextColor,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: w * .2,
                                    child: Text(
                                      "Name",
                                      style: getRegularStyle(
                                        color: Colormanager.mainTextColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * .3,
                                    child: Text(
                                      " Department",
                                      style: getRegularStyle(
                                        color: Colormanager.mainTextColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * .2,
                                    child: Text(
                                      "Cost",
                                      style: getRegularStyle(
                                        color: Colormanager.mainTextColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Selling",
                                    style: getRegularStyle(
                                      color: Colormanager.mainTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Material(
                            //   color: Colormanager.teritiory,
                            //   borderRadius: BorderRadius.circular(5),
                            //   child: InkWell(
                            //     splashColor: Colormanager.primary,
                            //     borderRadius: BorderRadius.circular(5),
                            //     onTap: () {
                            //       Navigator.push(context,
                            //           MaterialPageRoute(builder: (ctx) {
                            //         return const ItemMasterScreen();
                            //       }));
                            //     },
                            //     child: Container(
                            //       width: 30,
                            //       height: 30,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //       child: Center(
                            //           child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: const [
                            //           Icon(Icons.filter_alt),
                            //         ],
                            //       )),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: TextField(
                                  controller: ItemMasterControllers
                                      .viewitemnameController,
                                  onChanged: (value) {
                                    value.isEmpty
                                        ? BlocProvider.of<LoginBloc>(context)
                                            .add(OptionPageEvent())
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () async {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(
                                            SearchItemMasterEvent(),
                                          );
                                        },
                                      ),
                                      hintText: 'Enter name',
                                      hintStyle: getRegularStyle(
                                          color: Colors.grey, fontSize: 15),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colormanager.amber,
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  decoration: BoxDecoration(
                                      color: Colormanager.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colormanager.amber)),
                                  child: DropdownButtonHideUnderline(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton2<
                                                  DepartmentList>(
                                              isExpanded: true,
                                              iconStyleData:
                                                  const IconStyleData(),
                                              hint: Text("Select Department",
                                                  style: getRegularStyle(
                                                      color: const Color.fromARGB(
                                                          255, 173, 173, 173),
                                                      fontSize: 15)),
                                              items: state.itemGetConfig
                                                  ?.departmentList!
                                                  .map((item) =>
                                                      DropdownMenuItem<
                                                          DepartmentList>(
                                                        value: item,
                                                        child: Text(
                                                            item.name ?? '',
                                                            style: getRegularStyle(
                                                                color: Colormanager
                                                                    .mainTextColor,
                                                                fontSize: 15)),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  ItemMasterControllers
                                                      .viewitemdepnameController
                                                      .text = value?.name as String;
                                                });
                                                // ItemMasterControllers
                                                //     .departmentNameController
                                                //     .text = defDepartment ?? '';
                                                ItemMasterControllers
                                                        .viewitemdepController
                                                        .text =
                                                    value?.id.toString() ?? '';
                                              },
                                              customButton: ItemMasterControllers
                                                          .viewitemdepnameController
                                                          .text
                                                          .isEmpty ||
                                                      ItemMasterControllers
                                                              .viewitemdepnameController
                                                              .text ==
                                                          'null'
                                                  ? null
                                                  : Row(
                                                      children: [
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    15,
                                                                    10,
                                                                    15),
                                                            child: Text(
                                                                ItemMasterControllers
                                                                    .viewitemdepnameController
                                                                    .text,
                                                                style: getRegularStyle(
                                                                    color: Colormanager
                                                                        .textColor,
                                                                    fontSize:
                                                                        12)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                height: 40,
                                                padding: EdgeInsets.fromLTRB(
                                                    12, 0, 12, 0),
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .5,
                                              ),
                                              dropdownSearchData:
                                                  DropdownSearchData(
                                                searchInnerWidgetHeight: 20,
                                                searchController:
                                                    ItemMasterControllers
                                                        .viewitemSearchdepController,
                                                searchInnerWidget: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 4,
                                                    right: 8,
                                                    left: 8,
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        ItemMasterControllers
                                                            .viewitemSearchdepController,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 10,
                                                        vertical: 8,
                                                      ),
                                                      hintText:
                                                          "Search Department",
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 12),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                searchMatchFn:
                                                    (item, searchValue) {
                                                  return (item.value!.name
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(searchValue));
                                                },
                                              ),
                                              onMenuStateChange: (isOpen) {
                                                if (!isOpen) {
                                                  ItemMasterControllers
                                                      .viewitemSearchdepController
                                                      .clear();
                                                }
                                              }
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
                                        IconButton(
                                          icon: const Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            // await ItemImp().getItems();
                                            // setState(() {});
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(
                                              SearchItemMasterEvent(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  //   ],
                                  // ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return Material(
                              color: (index % 2) != 0
                                  ? Colormanager.white
                                  : Colormanager.teritiory,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                splashColor: Colormanager.primary,
                                borderRadius: BorderRadius.circular(5),
                                onTap: () async {
                                  Navigator.pushNamed(
                                      context, Routes.viewPageLoading);
                                  final s = await ItemImp(
                                          itemId: state
                                              .getItems?.items?[index].barcode
                                              .toString(),
                                          state: state)
                                      .getItemById();
                                  s.fold((falure) {
                                    print(falure);
                                  },
                                      (success) =>
                                          Navigator.pushReplacementNamed(
                                              context, Routes.viewPage));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   // "${index + 1}",
                                        //   state.getItems?.items?[index].id
                                        //           .toString() ??
                                        //       '',
                                        //   style: getRegularStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 10),
                                        // ),
                                        SizedBox(
                                          width: w * .2,
                                          child: Text(
                                            state.getItems?.items?[index]
                                                    .itemName ??
                                                '',
                                            style: getRegularStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          width: w * .3,
                                          child: Text(
                                            state.getItems?.items?[index]
                                                        .departmentId
                                                        .toString() !=
                                                    '{}'
                                                ? getDepNameById(
                                                    state
                                                            .getItems
                                                            ?.items?[index]
                                                            .departmentId ??
                                                        0,
                                                    state.itemGetConfig
                                                            ?.departmentList ??
                                                        [])
                                                : '',
                                            style: getRegularStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          width: w * .2,
                                          child: Text(
                                            state.getItems?.items?[index]
                                                    .costPrice
                                                    .toString() ??
                                                '',
                                            style: getRegularStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                        Text(
                                          state.getItems?.items?[index]
                                                  .sellingPrice
                                                  .toString() ??
                                              '',
                                          style: getRegularStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          itemCount: state.getItems?.items?.length,
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _currentPage >= 2
                                ? InkWell(
                                    onTap: () {
                                      _currentPage--;
                                      setState(() {});
                                      BlocProvider.of<LoginBloc>(context).add(
                                        GetNewItemsEvent(
                                            pageNumber: _currentPage),
                                      );
                                    },
                                    child: const SizedBox(
                                        height: 30,
                                        child: Icon(Icons.arrow_back_ios)),
                                  )
                                : Container(),
                            Text(
                              _currentPage.toString(),
                              style: getBoldStyle(
                                  color: Colormanager.primary, fontSize: 15),
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is OptionPageState &&
                                        state.isEmpty == false ||
                                    _currentPage == 1) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentPage++;
                                      });
                                      print(_currentPage);
                                      BlocProvider.of<LoginBloc>(context).add(
                                        GetNewItemsEvent(
                                            pageNumber: _currentPage),
                                      );
                                    },
                                    child: const SizedBox(
                                        height: 30,
                                        child: Icon(Icons.arrow_forward_ios)),
                                  );
                                } else if (state is OptionPageState &&
                                    state.isEmpty == true) {
                                  return Container();
                                }
                                return const InkWell(
                                  child: SizedBox(
                                      height: 30,
                                      child: Icon(Icons.arrow_forward_ios)),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              }));
  }
}
