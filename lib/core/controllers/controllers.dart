import 'package:flutter/cupertino.dart';

class LoginControllers {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController passWordController = TextEditingController();
}

class UserControllers {
  static TextEditingController nameController = TextEditingController();
}

class EditProfileControllers {
  static TextEditingController firstController = TextEditingController();
  static TextEditingController lastController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController emailIdController = TextEditingController();
}

class ItemMasterControllers {
  static TextEditingController itemId = TextEditingController();
  static TextEditingController activeController = TextEditingController();
  static TextEditingController nonStockController = TextEditingController();
  static TextEditingController counterStockController = TextEditingController();
  static TextEditingController barCodeController = TextEditingController();
  static TextEditingController barCodeController2 = TextEditingController();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController shortNameController = TextEditingController();
  static TextEditingController arabicController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController categoryController = TextEditingController();
  static TextEditingController subCategoryController = TextEditingController();
  static TextEditingController brandController = TextEditingController();
  static TextEditingController supplierController = TextEditingController();
  static TextEditingController supplierNameController = TextEditingController();
  static TextEditingController departmentNameController =
      TextEditingController();
  static TextEditingController categoryNameController = TextEditingController();
  static TextEditingController subCategoryNameController =
      TextEditingController();
  static TextEditingController supplierCodeController = TextEditingController();
  static TextEditingController containController = TextEditingController();
  static TextEditingController remarksController = TextEditingController();
  static TextEditingController rackNoController = TextEditingController();
  static TextEditingController shelfNoController = TextEditingController();
  static TextEditingController costPriceController = TextEditingController();
  static TextEditingController costWithTaxController = TextEditingController();
  static TextEditingController marginPerController = TextEditingController();
  static TextEditingController marginController = TextEditingController();
  static TextEditingController sellingPController = TextEditingController();
  static TextEditingController sellingPriceWithTaxController =
      TextEditingController();
  static TextEditingController searchSupController = TextEditingController();
  static TextEditingController searchSubCatController = TextEditingController();
  static TextEditingController searchCatController = TextEditingController();
  static TextEditingController searchdepController = TextEditingController();
  static TextEditingController searchUnitController = TextEditingController();
  static TextEditingController selectedunitController = TextEditingController();
  static TextEditingController createddateController = TextEditingController();
  static TextEditingController moddateController = TextEditingController();
  static TextEditingController viewitemnameController = TextEditingController();
  static TextEditingController viewitemdepnameController =
      TextEditingController();
  static TextEditingController viewitemdepController = TextEditingController();
  static TextEditingController viewitemSearchdepController =
      TextEditingController();
  static cleanControllers() {
    departmentNameController.clear();
    supplierController.clear();
    supplierNameController.clear();
    supplierCodeController.clear();
    categoryNameController.clear();
    subCategoryNameController.clear();
    departmentController.clear();
    nameController.clear();
    shortNameController.clear();
    arabicController.clear();
    rackNoController.clear();
    shelfNoController.clear();
    costPriceController.clear();
    costWithTaxController.clear();
    marginPerController.clear();
    marginController.clear();
    sellingPController.clear();
    sellingPriceWithTaxController.clear();
    barCodeController.clear();
  }

  static cleanControllersOnCostChange() {
    marginPerController.clear();
    marginController.clear();
    sellingPController.clear();
    sellingPriceWithTaxController.clear();
  }
}

class ItemMasterCloneControllers {
  static TextEditingController cdefTaxId = TextEditingController();
  static TextEditingController cdefTaxRate = TextEditingController();
  static TextEditingController cdefTaxName = TextEditingController();
  static TextEditingController cbarCodeController = TextEditingController();
  static TextEditingController cbarCodeController2 = TextEditingController();
  static TextEditingController cnameController = TextEditingController();
  static TextEditingController cshortNameController = TextEditingController();
  static TextEditingController carabicController = TextEditingController();
  static TextEditingController cdepartmentController = TextEditingController();
  static TextEditingController ccategoryController = TextEditingController();
  static TextEditingController csubCategoryController = TextEditingController();
  static TextEditingController cbrandController = TextEditingController();
  static TextEditingController csupplierController = TextEditingController();
  static TextEditingController csupplierCodeController =
      TextEditingController();
  static TextEditingController csupplierNameController =
      TextEditingController();
  static TextEditingController cdepartmentNameController =
      TextEditingController();
  static TextEditingController ccategoryNameController =
      TextEditingController();
  static TextEditingController csubCategoryNameController =
      TextEditingController();
  static TextEditingController cremarksController = TextEditingController();
  static TextEditingController crackNoController = TextEditingController();
  static TextEditingController cshelfNoController = TextEditingController();
  static TextEditingController ccostPriceController = TextEditingController();
  static TextEditingController ccostWithTaxController = TextEditingController();
  static TextEditingController cmarginPerController = TextEditingController();
  static TextEditingController cmarginController = TextEditingController();
  static TextEditingController csellingPController = TextEditingController();
  static TextEditingController csellingPriceWithTaxController =
      TextEditingController();

  static clone() {
    // ItemMasterControllers.barCodeController.text =
    //     ItemMasterCloneControllers.cbarCodeController.text;

    ItemMasterControllers.departmentNameController.text =
        cdepartmentNameController.text;

    ItemMasterControllers.categoryNameController.text =
        ccategoryNameController.text;
    ItemMasterControllers.subCategoryNameController.text =
        csubCategoryNameController.text;

    ItemMasterControllers.barCodeController2.text = cbarCodeController2.text;
    ItemMasterControllers.nameController.text = cnameController.text;
    ItemMasterControllers.shortNameController.text = cshortNameController.text;
    ItemMasterControllers.arabicController.text = carabicController.text;
    ItemMasterControllers.departmentController.text =
        cdepartmentController.text;
    ItemMasterControllers.categoryController.text = ccategoryController.text;
    ItemMasterControllers.subCategoryController.text =
        csubCategoryController.text;
    ItemMasterControllers.brandController.text = cbrandController.text;
    ItemMasterControllers.supplierController.text = csupplierController.text;
    ItemMasterControllers.supplierCodeController.text =
        csupplierCodeController.text;
    ItemMasterControllers.supplierNameController.text =
        csupplierNameController.text;
    ItemMasterControllers.remarksController.text = cremarksController.text;
    ItemMasterControllers.rackNoController.text = crackNoController.text;
    ItemMasterControllers.shelfNoController.text = cshelfNoController.text;
    ItemMasterControllers.costPriceController.text = ccostPriceController.text;
    ItemMasterControllers.costWithTaxController.text =
        ccostWithTaxController.text;
    ItemMasterControllers.marginPerController.text = cmarginPerController.text;
    ItemMasterControllers.marginController.text = cmarginController.text;
    ItemMasterControllers.sellingPController.text = csellingPController.text;
    ItemMasterControllers.sellingPriceWithTaxController.text =
        csellingPriceWithTaxController.text;
  }

  static save() {
    print(ItemMasterCloneControllers.cnameController.text);
    cdepartmentNameController.text =
        ItemMasterControllers.departmentNameController.text;
    ccategoryNameController.text =
        ItemMasterControllers.categoryNameController.text;
    csubCategoryNameController.text =
        ItemMasterControllers.subCategoryNameController.text;
    cbarCodeController.text = ItemMasterControllers.barCodeController.text;
    cbarCodeController2.text = ItemMasterControllers.barCodeController2.text;
    cnameController.text = ItemMasterControllers.nameController.text;
    cshortNameController.text = ItemMasterControllers.shortNameController.text;
    carabicController.text = ItemMasterControllers.arabicController.text;
    csupplierNameController.text =
        ItemMasterControllers.supplierNameController.text;

    cdepartmentController.text =
        ItemMasterControllers.departmentController.text;
    ccategoryController.text = ItemMasterControllers.categoryController.text;
    csubCategoryController.text =
        ItemMasterControllers.subCategoryController.text;
    cbrandController.text = ItemMasterControllers.brandController.text;
    csupplierController.text = ItemMasterControllers.supplierController.text;
    csupplierCodeController.text =
        ItemMasterControllers.supplierCodeController.text;
    cremarksController.text = ItemMasterControllers.remarksController.text;
    crackNoController.text = ItemMasterControllers.rackNoController.text;
    cshelfNoController.text = ItemMasterControllers.shelfNoController.text;
    ccostPriceController.text = ItemMasterControllers.costPriceController.text;
    ccostWithTaxController.text =
        ItemMasterControllers.costWithTaxController.text;
    cmarginPerController.text = ItemMasterControllers.marginPerController.text;
    cmarginController.text = ItemMasterControllers.marginController.text;
    csellingPController.text = ItemMasterControllers.sellingPController.text;
    csellingPriceWithTaxController.text =
        ItemMasterControllers.sellingPriceWithTaxController.text;
    ItemMasterControllers.cleanControllers();
  }
}

class AlterUnitControllers {
  static TextEditingController itemMasterCode = TextEditingController();
  static TextEditingController barcodeAlt = TextEditingController();
  static TextEditingController barcodeAltText = TextEditingController();
  static TextEditingController weightingScaleItem = TextEditingController();
  static TextEditingController unitId = TextEditingController();
  static TextEditingController contain = TextEditingController();
  static TextEditingController cCode = TextEditingController();
  static TextEditingController altName = TextEditingController();
  static TextEditingController pluno = TextEditingController();
  static TextEditingController refcode = TextEditingController();
}

class PrintControllers {
  static TextEditingController name = TextEditingController();
  static TextEditingController barcode = TextEditingController();
  static TextEditingController sellingPrice = TextEditingController();
  static TextEditingController costPrice = TextEditingController();

  static clearControllers() {
    name.clear();
    sellingPrice.clear();
    costPrice.clear();
  }
}

class ProductPurchaseController {
  static TextEditingController supCode = TextEditingController();
  static TextEditingController supName = TextEditingController();
  static TextEditingController invNo = TextEditingController();
  static TextEditingController invDate = TextEditingController();
  static TextEditingController invTotal = TextEditingController();
  static TextEditingController barCodeContorller = TextEditingController();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController selling = TextEditingController();
  static TextEditingController qty = TextEditingController();
  static TextEditingController foc = TextEditingController();
  static TextEditingController costPrice = TextEditingController();
  static TextEditingController discount = TextEditingController();
  static TextEditingController taxNameCon = TextEditingController();
  static TextEditingController taxId = TextEditingController();
  static TextEditingController ratetax = TextEditingController();
  static TextEditingController total = TextEditingController();
  //   static TextEditingController invNo = TextEditingController();
  // static TextEditingController ratetax = TextEditingController();
  // static TextEditingController total = TextEditingController();
}

class UrlController {
  static TextEditingController url = TextEditingController();
}
