// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      result: json['result'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'token': instance.token,
    };
