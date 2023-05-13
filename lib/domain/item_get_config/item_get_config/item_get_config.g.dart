// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_get_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGetConfig _$ItemGetConfigFromJson(Map<String, dynamic> json) =>
    ItemGetConfig(
      enablereversecalculation:
          (json['ENABLEREVERSECALCULATION'] as List<dynamic>?)
              ?.map((e) =>
                  Enablereversecalculation.fromJson(e as Map<String, dynamic>))
              .toList(),
      acCompanyData: (json['AcCompanyData'] as List<dynamic>?)
          ?.map((e) => AcCompanyDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastbarcode: (json['lastbarcode'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      barcodeConfig: (json['BarcodeConfig'] as List<dynamic>?)
          ?.map((e) => BarcodeConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryList: (json['CategoryList'] as List<dynamic>?)
          ?.map((e) => CategoryList.fromJson(e as Map<String, dynamic>))
          .toList(),
      departmentList: (json['DepartmentList'] as List<dynamic>?)
          ?.map((e) => DepartmentList.fromJson(e as Map<String, dynamic>))
          .toList(),
      taxList: (json['TaxList'] as List<dynamic>?)
          ?.map((e) => TaxList.fromJson(e as Map<String, dynamic>))
          .toList(),
      secondCategoryList: (json['SecondCategoryList'] as List<dynamic>?)
          ?.map((e) => SecondCategoryList.fromJson(e as Map<String, dynamic>))
          .toList(),
      supplierMasterList: (json['SupplierMasterList'] as List<dynamic>?)
          ?.map((e) => SupplierMasterList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemGetConfigToJson(ItemGetConfig instance) =>
    <String, dynamic>{
      'ENABLEREVERSECALCULATION': instance.enablereversecalculation,
      'AcCompanyData': instance.acCompanyData,
      'lastbarcode': instance.lastbarcode,
      'BarcodeConfig': instance.barcodeConfig,
      'CategoryList': instance.categoryList,
      'DepartmentList': instance.departmentList,
      'TaxList': instance.taxList,
      'SecondCategoryList': instance.secondCategoryList,
      'SupplierMasterList': instance.supplierMasterList,
    };
