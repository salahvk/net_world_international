import 'package:json_annotation/json_annotation.dart';

part 'supplier_master_list.g.dart';

@JsonSerializable()
class SupplierMasterList {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? mobile;
  String? fax;
  String? email;
  dynamic acCode;
  dynamic opBal;
  dynamic supplierType;
  dynamic cCode;
  String? contactPerson;
  String? designation;
  String? code;
  String? remarks;
  dynamic creditDays;
  String? chequeName;
  String? trEmirates;
  String? moreDet;
  bool? inactive;
  @JsonKey(name: 'exlVAT')
  bool? exlVat;

  SupplierMasterList({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.mobile,
    this.fax,
    this.email,
    this.acCode,
    this.opBal,
    this.supplierType,
    this.cCode,
    this.contactPerson,
    this.designation,
    this.code,
    this.remarks,
    this.creditDays,
    this.chequeName,
    this.trEmirates,
    this.moreDet,
    this.inactive,
    this.exlVat,
  });

  factory SupplierMasterList.fromJson(Map<String, dynamic> json) {
    return _$SupplierMasterListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SupplierMasterListToJson(this);
}
