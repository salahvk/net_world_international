import 'package:net_world_international/core/util/global_list.dart';
import 'package:net_world_international/domain/item_config/item_config.dart';

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

String getSecondCategoryId(int id, List<CategoryList> categoryList) {
  for (var category in categoryList) {
    if (category.id == id) {
      return category.name ?? '';
    }
  }
  return 'null';
}

String getSupplierNameById(String id, List<SupplierMasterList> supplierList) {
  for (var supplier in supplierList) {
    try {
      if (supplier.id == int.parse(id)) {
        return supplier.name ?? '';
      }
    } catch (_) {
      return 'null';
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

TaxList getTaxListById(
  int id,
) {
  for (var tax in GlobalList().taxList) {
    if (tax.taxId == id) {
      return tax;
    }
  }
  return TaxList();
}
