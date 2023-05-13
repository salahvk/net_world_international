// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeConfig _$BarcodeConfigFromJson(Map<String, dynamic> json) =>
    BarcodeConfig(
      paramId: json['paramID'] as String?,
      paramText: json['paramText'] as String?,
      paramSubId: json['paramSubId'] as String?,
      paramVal: json['paramVal'] as String?,
    );

Map<String, dynamic> _$BarcodeConfigToJson(BarcodeConfig instance) =>
    <String, dynamic>{
      'paramID': instance.paramId,
      'paramText': instance.paramText,
      'paramSubId': instance.paramSubId,
      'paramVal': instance.paramVal,
    };
