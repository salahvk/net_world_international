import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/routes_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Id",
                          style: getRegularStyle(
                            color: Colormanager.mainTextColor,
                          ),
                        ),
                        Text(
                          "Name",
                          style: getRegularStyle(
                            color: Colormanager.mainTextColor,
                          ),
                        ),
                        // Text("Unit"),
                        // Text("Contain"),
                        Text(
                          "Cost",
                          style: getRegularStyle(
                            color: Colormanager.mainTextColor,
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
                  const Divider(),
                  Expanded(
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is OptionPageState) {
                          final cuState = state;
                          return ListView.builder(
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
                                    final s = await ItemImp(
                                            itemId: state
                                                .getItems?.items?[index].id
                                                .toString(),
                                            state: cuState)
                                        .getItemById();
                                    s.fold(
                                        (falure) {},
                                        (success) => Navigator.pushNamed(
                                            context, Routes.viewPage));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // "${index + 1}",
                                            state.getItems?.items?[index].id
                                                    .toString() ??
                                                '',
                                            style: getRegularStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            state.getItems?.items?[index]
                                                    .name ??
                                                '',
                                            style: getRegularStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            state.getItems?.items?[index]
                                                    .costPrice
                                                    .toString() ??
                                                '',
                                            style: getRegularStyle(
                                                color: Colors.black,
                                                fontSize: 10),
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
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _currentPage >= 2
                          ? InkWell(
                              onTap: () {
                                _currentPage--;
                                setState(() {});
                                BlocProvider.of<LoginBloc>(context).add(
                                  GetNewItemsEvent(pageNumber: _currentPage),
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
                                BlocProvider.of<LoginBloc>(context).add(
                                  GetNewItemsEvent(pageNumber: _currentPage),
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
            ),
    );
  }
}
