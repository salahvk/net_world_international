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
  LoggedIn({this.userModel, this.loginModel});
}

class LoggedOut extends LoginState {}
