// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsModel _$UserDetailsModelFromJson(Map<String, dynamic> json) =>
    UserDetailsModel(
      username: json['username'] as String?,
      inactive: json['inactive'] as String?,
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      photoPath: json['photo_path'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailsModelToJson(UserDetailsModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'inactive': instance.inactive,
      'userId': instance.userId,
      'name': instance.name,
      'photo_path': instance.photoPath,
      'result': instance.result,
    };
