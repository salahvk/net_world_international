part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class Initial extends LoginState {}

class Loading extends LoginState {}

class Error extends LoginState {}

// class Loaded extends LoginState {
//   LoginModel? loginModel;
//   final UserDetailsModel userModel;

//   Loaded({this.loginModel, required this.userModel});
// }

class LoggedIn extends LoginState {
  LoginModel? loginModel;
  UserDetailsModel? userModel;
  ItemGetConfig? itemGetConfig;
  String? barCode1;
  String? barCode2;
  GetitemsModel? getItems;
  LoggedIn(
      {this.userModel,
      this.loginModel,
      this.itemGetConfig,
      this.barCode1,
      this.barCode2,
      this.getItems});
}

class LoggedOut extends LoginState {}
