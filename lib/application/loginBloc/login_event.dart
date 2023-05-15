part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class NavigateToMainScreenEvent extends LoginEvent {}

class UpdateProfilePicEvent extends LoginEvent {}

class UpdateNameEvent extends LoginEvent {}

class NavigateToHomeScreenEvent extends LoginEvent {}

class GetItemConfigEvent extends LoginEvent {}



// class LoggedOutEvent extends LoginEvent {}
