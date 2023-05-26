import 'package:json_annotation/json_annotation.dart';

part 'department_list.g.dart';

@JsonSerializable()
class DepartmentList {
  dynamic id;
  String? name;
  dynamic purchaseAcCode;
  dynamic salesAcCode;
  String? code;
  String? arabicName;
  dynamic defaultmargin;
  dynamic showInCounterClose;
  int? taxId;

  DepartmentList({
    this.id,
    this.name,
    this.purchaseAcCode,
    this.salesAcCode,
    this.code,
    this.arabicName,
    this.defaultmargin,
    this.showInCounterClose,
    this.taxId,
  });

  factory DepartmentList.fromJson(Map<String, dynamic> json) {
    return _$DepartmentListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmentListToJson(this);
}
