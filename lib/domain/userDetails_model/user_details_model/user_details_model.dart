import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'user_details_model.g.dart';

@JsonSerializable()
class UserDetailsModel {
  String? username;
  String? inactive;
  String? userId;
  String? name;
  @JsonKey(name: 'photo_path')
  String? photoPath;
  Result? result;

  UserDetailsModel({
    this.username,
    this.inactive,
    this.userId,
    this.name,
    this.photoPath,
    this.result,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$UserDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);
}
