import 'package:json_annotation/json_annotation.dart';

part 'tax_list.g.dart';

@JsonSerializable()
class TaxList {
  int? taxId;
  String? taxName;
  dynamic taxRate;
  bool? defaltTax;

  TaxList({this.taxId, this.taxName, this.taxRate, this.defaltTax});

  factory TaxList.fromJson(Map<String, dynamic> json) {
    return _$TaxListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaxListToJson(this);
}
