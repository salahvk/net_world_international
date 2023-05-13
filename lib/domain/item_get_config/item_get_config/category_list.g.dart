// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) => CategoryList(
      id: json['id'],
      name: json['name'] as String?,
      code: json['code'] as String?,
      cKeys: json['cKeys'] as String?,
      departmentId: json['departmentID'],
    );

Map<String, dynamic> _$CategoryListToJson(CategoryList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'cKeys': instance.cKeys,
      'departmentID': instance.departmentId,
    };
