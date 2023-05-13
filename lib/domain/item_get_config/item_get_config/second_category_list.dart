import 'package:json_annotation/json_annotation.dart';

part 'second_category_list.g.dart';

@JsonSerializable()
class SecondCategoryList {
  int? id;
  String? name;

  SecondCategoryList({this.id, this.name});

  factory SecondCategoryList.fromJson(Map<String, dynamic> json) {
    return _$SecondCategoryListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SecondCategoryListToJson(this);
}
