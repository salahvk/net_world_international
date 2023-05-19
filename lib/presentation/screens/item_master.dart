import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
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
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(" Id:"),
                        Text("Name"),
                        // Text("Unit"),
                        // Text("Contain"),
                        Text("Cost"),
                        Text("Selling"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is OptionPageState) {
                          print("state");
                          return ListView.builder(
                            shrinkWrap: true,

                            // physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: (index % 2) != 0
                                        ? Colormanager.white
                                        : Colormanager.teritiory),
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
                                            color: Colors.black, fontSize: 10),
                                      ),
                                      Text(
                                        state.getItems?.items?[index].name ??
                                            '',
                                        style: getRegularStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                      Text(
                                        state.getItems?.items?[index].costPrice
                                                .toString() ??
                                            '',
                                        style: getRegularStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                      Text(
                                        state.getItems?.items?[index]
                                                .sellingPrice
                                                .toString() ??
                                            '',
                                        style: getRegularStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ],
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
                                print(_currentPage);
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
                      InkWell(
                        onTap: () {
                          _currentPage++;
                          setState(() {});
                          print(_currentPage);
                          BlocProvider.of<LoginBloc>(context).add(
                            GetNewItemsEvent(pageNumber: _currentPage),
                          );
                        },
                        child: const SizedBox(
                            height: 30, child: Icon(Icons.arrow_forward_ios)),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
