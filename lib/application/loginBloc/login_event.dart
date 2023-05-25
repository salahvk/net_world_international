part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class NavigateToMainScreenEvent extends LoginEvent {}

class UpdateProfilePicEvent extends LoginEvent {}

class UpdateNameEvent extends LoginEvent {}

class NavigateToHomeScreenEvent extends LoginEvent {}

class GetItemConfigEvent extends LoginEvent {}

class AddToItemMasterEvent extends LoginEvent {}

class HomePageEvent extends LoginEvent {}

class ProfilePageEvent extends LoginEvent {}

class OptionPageEvent extends LoginEvent {}

class GetNewItemsEvent extends LoginEvent {
  final int? pageNumber;
  GetNewItemsEvent({this.pageNumber});
}

class NextBarCodeEvent extends LoginEvent {
  final String? selectedThrow;
  final String? barcode;
  NextBarCodeEvent({this.selectedThrow, this.barcode});
}

class ItemViewByIdEvent extends LoginEvent {
  final String? id;
  ItemViewByIdEvent({this.id});
}
