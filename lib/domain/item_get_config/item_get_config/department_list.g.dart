// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentList _$DepartmentListFromJson(Map<String, dynamic> json) =>
    DepartmentList(
      id: json['id'],
      name: json['name'] as String?,
      purchaseAcCode: json['purchaseAcCode'],
      salesAcCode: json['salesAcCode'],
      code: json['code'] as String?,
      arabicName: json['arabicName'] as String?,
      defaultmargin: json['defaultmargin'],
      showInCounterClose: json['showInCounterClose'],
      taxId: json['taxId'] as int?,
    );

Map<String, dynamic> _$DepartmentListToJson(DepartmentList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'purchaseAcCode': instance.purchaseAcCode,
      'salesAcCode': instance.salesAcCode,
      'code': instance.code,
      'arabicName': instance.arabicName,
      'defaultmargin': instance.defaultmargin,
      'showInCounterClose': instance.showInCounterClose,
      'taxId': instance.taxId,
    };
