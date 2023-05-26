import 'package:json_annotation/json_annotation.dart';

part 'category_list.g.dart';

@JsonSerializable()
class CategoryList {
  dynamic id;
  String? name;
  String? code;
  String? cKeys;
  @JsonKey(name: 'departmentID')
  dynamic departmentId;

  CategoryList({
    this.id,
    this.name,
    this.code,
    this.cKeys,
    this.departmentId,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return _$CategoryListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);
}
