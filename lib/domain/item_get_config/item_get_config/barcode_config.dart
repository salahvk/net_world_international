import 'package:json_annotation/json_annotation.dart';

part 'barcode_config.g.dart';

@JsonSerializable()
class BarcodeConfig {
  @JsonKey(name: 'paramID')
  String? paramId;
  String? paramText;
  String? paramSubId;
  String? paramVal;

  BarcodeConfig({
    this.paramId,
    this.paramText,
    this.paramSubId,
    this.paramVal,
  });

  factory BarcodeConfig.fromJson(Map<String, dynamic> json) {
    return _$BarcodeConfigFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BarcodeConfigToJson(this);
}
