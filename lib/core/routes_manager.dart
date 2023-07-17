import 'package:flutter/material.dart';
import 'package:net_world_international/presentation/screens/change_password.dart';
import 'package:net_world_international/presentation/screens/edit_profile.dart';
import 'package:net_world_international/presentation/screens/get_help.dart';
import 'package:net_world_international/presentation/screens/item_view_page.dart';
import 'package:net_world_international/presentation/screens/loading_screens/loading_screen.dart';
import 'package:net_world_international/presentation/screens/login_page.dart';
import 'package:net_world_international/presentation/screens/main_screen.dart';
import 'package:net_world_international/presentation/screens/make_payment.dart';
import 'package:net_world_international/presentation/screens/product_purchase.dart';
import 'package:net_world_international/presentation/screens/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String paymentScreen = '/paymentScreen';
  static const String loginPage = '/loginPage';
  static const String mainScreen = '/mainScreen';
  static const String editProfile = '/editProfile';
  static const String changePassword = '/changePassword';
  static const String getHelp = '/getHelp';
  static const String viewPage = '/viewPage';
  static const String productPurPage = '/productPurchasePage';
   static const String viewPageLoading = '/viewPageLoading';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const MakePaymentScreen());
      case Routes.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case Routes.getHelp:
        return MaterialPageRoute(builder: (_) => const GetHelpScreen());
      case Routes.viewPage:
        return FadePageRoute(page: const ItemViewPage());
         case Routes.viewPageLoading:
        return FadePageRoute(page: const ViewPageLoading());
      case Routes.productPurPage:
        return MaterialPageRoute(builder: (_) => const ProductPurchasePage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found"),
        ),
      ),
    );
  }
}


class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
