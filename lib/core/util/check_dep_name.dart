import 'package:net_world_international/domain/item_get_config/item_get_config/category_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/department_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/supplier_master_list.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/tax_list.dart';

String getDepNameById(int id, List<DepartmentList> departmentList) {
  for (var department in departmentList) {
    if (department.id == id) {
      return department.name ?? '';
    }
  }
  return 'null';
}

String getCategoryNameById(int id, List<CategoryList> categoryList) {
  for (var category in categoryList) {
    if (category.id == id) {
      return category.name ?? '';
    }
  }
  return 'null';
}

String getSupplierNameById(String id, List<SupplierMasterList> supplierList) {
  for (var supplier in supplierList) {
    if (supplier.code == id) {
      return supplier.name ?? '';
    }
  }
  return 'null';
}

String getTaxNameById(int id, List<TaxList> taxList) {
  for (var tax in taxList) {
    if (tax.taxId == id) {
      return tax.taxName ?? '';
    }
  }
  return 'null';
}
