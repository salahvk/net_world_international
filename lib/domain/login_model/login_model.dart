import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String? username;
  String? inactive;
  String? userId;
  Result? result;

  LoginModel({this.username, this.inactive, this.userId, this.result});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
