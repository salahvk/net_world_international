import 'package:json_annotation/json_annotation.dart';

part 'unit_list.g.dart';

@JsonSerializable()
class UnitList {
  int? id;
  String? name;

  UnitList({this.id, this.name});

  factory UnitList.fromJson(Map<String, dynamic> json) {
    return _$UnitListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UnitListToJson(this);
}
