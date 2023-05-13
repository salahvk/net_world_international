import 'package:json_annotation/json_annotation.dart';

part 'ac_company_datum.g.dart';

@JsonSerializable()
class AcCompanyDatum {
  String? barcodeStartChar;
  String? altBarcodeStartChar;

  AcCompanyDatum({this.barcodeStartChar, this.altBarcodeStartChar});

  factory AcCompanyDatum.fromJson(Map<String, dynamic> json) {
    return _$AcCompanyDatumFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AcCompanyDatumToJson(this);
}
