part of 'login_bloc.dart';

abstract class LoginState {}

class Initial extends LoginState {}

class Loading extends LoginState {}

class Error extends LoginState {}

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

class HomePageState extends LoginState {
  LoginModel? loginModel;
  UserDetailsModel? userModel;

  HomePageState({
    this.userModel,
    this.loginModel,
  });
}

class ProfilePageState extends LoginState {
  LoginModel? loginModel;
  UserDetailsModel? userModel;

  ProfilePageState({
    this.userModel,
    this.loginModel,
  });
}

class OptionPageState extends LoginState {
  bool? isEmpty;
  LoginModel? loginModel;
  UserDetailsModel? userModel;
  ItemGetConfig? itemGetConfig;
  String? barCode1;
  String? barCode2;
  GetitemsModel? getItems;
  Items? itemViewById;
  OptionPageState(
      {this.userModel,
      this.isEmpty,
      this.loginModel,
      this.itemGetConfig,
      this.barCode1,
      this.barCode2,
      this.getItems,
      this.itemViewById});
}
