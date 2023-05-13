// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_master_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierMasterList _$SupplierMasterListFromJson(Map<String, dynamic> json) =>
    SupplierMasterList(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      mobile: json['mobile'] as String?,
      fax: json['fax'] as String?,
      email: json['email'] as String?,
      acCode: json['acCode'],
      opBal: json['opBal'],
      supplierType: json['supplierType'],
      cCode: json['cCode'],
      contactPerson: json['contactPerson'] as String?,
      designation: json['designation'] as String?,
      code: json['code'] as String?,
      remarks: json['remarks'] as String?,
      creditDays: json['creditDays'],
      chequeName: json['chequeName'] as String?,
      trEmirates: json['trEmirates'] as String?,
      moreDet: json['moreDet'] as String?,
      inactive: json['inactive'] as bool?,
      exlVat: json['exlVAT'] as bool?,
    );

Map<String, dynamic> _$SupplierMasterListToJson(SupplierMasterList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'fax': instance.fax,
      'email': instance.email,
      'acCode': instance.acCode,
      'opBal': instance.opBal,
      'supplierType': instance.supplierType,
      'cCode': instance.cCode,
      'contactPerson': instance.contactPerson,
      'designation': instance.designation,
      'code': instance.code,
      'remarks': instance.remarks,
      'creditDays': instance.creditDays,
      'chequeName': instance.chequeName,
      'trEmirates': instance.trEmirates,
      'moreDet': instance.moreDet,
      'inactive': instance.inactive,
      'exlVAT': instance.exlVat,
    };
