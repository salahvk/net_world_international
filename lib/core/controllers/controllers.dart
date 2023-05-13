import 'package:flutter/cupertino.dart';

class LoginControllers {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController passWordController = TextEditingController();
}

class EditProfileControllers {
  static TextEditingController firstController = TextEditingController();
  static TextEditingController lastController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController emailIdController = TextEditingController();
}

class ItemMasterControllers {
  static TextEditingController barCodeController = TextEditingController();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController shortNameController = TextEditingController();
  static TextEditingController arabicController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController categoryController = TextEditingController();
  static TextEditingController subCategoryController = TextEditingController();
  static TextEditingController brandController = TextEditingController();
  static TextEditingController supplierController = TextEditingController();
  static TextEditingController supplierCodeController = TextEditingController();
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
  static cleanControllers() {
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
