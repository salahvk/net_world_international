import 'package:json_annotation/json_annotation.dart';

part 'enablereversecalculation.g.dart';

@JsonSerializable()
class Enablereversecalculation {
  String? paramSubId;
  String? paramVal;

  Enablereversecalculation({this.paramSubId, this.paramVal});

  factory Enablereversecalculation.fromJson(Map<String, dynamic> json) {
    return _$EnablereversecalculationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EnablereversecalculationToJson(this);
}
