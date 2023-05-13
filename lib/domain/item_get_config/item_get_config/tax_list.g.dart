// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxList _$TaxListFromJson(Map<String, dynamic> json) => TaxList(
      taxId: json['taxId'] as int?,
      taxName: json['taxName'] as String?,
      taxRate: json['taxRate'],
      defaltTax: json['defaltTax'] as bool?,
    );

Map<String, dynamic> _$TaxListToJson(TaxList instance) => <String, dynamic>{
      'taxId': instance.taxId,
      'taxName': instance.taxName,
      'taxRate': instance.taxRate,
      'defaltTax': instance.defaltTax,
    };
