import 'package:json_annotation/json_annotation.dart';

import 'ac_company_datum.dart';
import 'barcode_config.dart';
import 'category_list.dart';
import 'department_list.dart';
import 'enablereversecalculation.dart';
import 'second_category_list.dart';
import 'supplier_master_list.dart';
import 'tax_list.dart';

part 'item_get_config.g.dart';

@JsonSerializable()
class ItemGetConfig {
  @JsonKey(name: 'ENABLEREVERSECALCULATION')
  List<Enablereversecalculation>? enablereversecalculation;
  @JsonKey(name: 'AcCompanyData')
  List<AcCompanyDatum>? acCompanyData;
  List<String>? lastbarcode;
  @JsonKey(name: 'BarcodeConfig')
  List<BarcodeConfig>? barcodeConfig;
  @JsonKey(name: 'CategoryList')
  List<CategoryList>? categoryList;
  @JsonKey(name: 'DepartmentList')
  List<DepartmentList>? departmentList;
  @JsonKey(name: 'TaxList')
  List<TaxList>? taxList;
  @JsonKey(name: 'SecondCategoryList')
  List<SecondCategoryList>? secondCategoryList;
  @JsonKey(name: 'SupplierMasterList')
  List<SupplierMasterList>? supplierMasterList;

  ItemGetConfig({
    this.enablereversecalculation,
    this.acCompanyData,
    this.lastbarcode,
    this.barcodeConfig,
    this.categoryList,
    this.departmentList,
    this.taxList,
    this.secondCategoryList,
    this.supplierMasterList,
  });

  factory ItemGetConfig.fromJson(Map<String, dynamic> json) {
    return _$ItemGetConfigFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemGetConfigToJson(this);
}
