import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/util/currenttime.dart';
import 'package:net_world_international/domain/add_items_model.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/services/add_item_services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: AddItemServices)
class AddItemImp implements AddItemServices {
  final int? id;
  bool isAlter = false;

  AddItemImp({this.id, required this.isAlter});

  @override
  Future<Either<MainFailure, AddItems>> saveToItemMaster() async {
    getCurrentDateTimeAndStore();
    try {
      String? deviceId;
      try {
        deviceId = await PlatformDeviceId.getDeviceId;
      } on PlatformException {
        deviceId = 'Failed to get deviceId.';
      }
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl = "$endPoint${ApiEndPoint.saveItems}";
      final url = Uri.parse(apiUrl);
      final accessToken = Hive.box("token").get('api_token');

      // values
      String userId = Hive.box("token").get('user_id');

      String depInput = ItemMasterCloneControllers.cdepartmentController.text;
      int departmentId = depInput.isNotEmpty ? int.parse(depInput) : 0;

      String categoryInput = ItemMasterControllers.categoryController.text;
      int categoryId = categoryInput.isNotEmpty ? int.parse(categoryInput) : 0;

      String taxInput = ItemMasterCloneControllers.cdefTaxId.text;
      int taxId = taxInput.isNotEmpty ? int.parse(taxInput) : 0;

      String supplierCode = ItemMasterControllers.supplierCodeController.text;
      String sCode = supplierCode.isEmpty
          ? "String"
          : ItemMasterControllers.supplierCodeController.text;

      String scategoryInput = ItemMasterControllers.subCategoryController.text;

      int scategoryId = scategoryInput.isNotEmpty && scategoryInput != 'null'
          ? int.parse(scategoryInput)
          : 0;

      //  is Alter variables

      String categoryInputA =
          ItemMasterCloneControllers.ccategoryController.text;

      int categoryIdA =
          categoryInputA.isNotEmpty ? int.parse(categoryInputA) : 0;

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String barcode;
      if (ItemMasterControllers.barCodeController2.text.isEmpty) {
        barcode = ItemMasterControllers.barCodeController.text;
      } else {
        barcode = ItemMasterControllers.barCodeController2.text;
      }
      String body = '';

      if (isAlter) {
        body = jsonEncode({
          "name": ItemMasterCloneControllers.cnameController.text,
          "shortName": ItemMasterCloneControllers.cshortNameController.text,
          "categoryId": categoryIdA,
          "sellingPrice":
              num.parse(ItemMasterCloneControllers.csellingPController.text),
          "costPrice":
              num.parse(ItemMasterCloneControllers.ccostPriceController.text),
          "barcode": barcode,
          "supplierItemCode":
              ItemMasterCloneControllers.csupplierController.text,
          "departmentId": departmentId,
          "firstcategoryId": categoryId,
          "secondCategoryid": scategoryId,
          "nonStockItem":
              (ItemMasterControllers.nonStockController.text.toLowerCase() ==
                  'true'),
          "counterStock": (ItemMasterControllers.counterStockController.text
                  .toLowerCase() ==
              'true'),
          "active":
              (ItemMasterControllers.activeController.text.toLowerCase() ==
                  'true'),
          "weighingScaleItem": true,
          "shelfNo": ItemMasterCloneControllers.cshelfNoController.text,
          "rackNo": ItemMasterCloneControllers.crackNoController.text,
          "supplierCode": sCode,
          "arabicname": ItemMasterCloneControllers.carabicController.text,
          "remarks": ItemMasterControllers.remarksController.text,
          "taxId": taxId,
          "delFlag": false,
          "modDate": ItemMasterControllers.moddateController.text,
          "modUser": UserControllers.nameController.text,
          "createUser": UserControllers.nameController.text,
          "itemMasterId": ItemMasterControllers.itemId.text,
          "unitId": ItemMasterControllers.selectedunitController.text,
          "deviceName": deviceId,
          "userId": userId,
          "basePrice": 0,
          "weighingItemType": 0,
          "loadItems": true,
          "itemGroup": "",
          "foCitem": true,
          "sellingUnitId": 0,
          "leadtime": 0,
          "sellingpricePackingUnit": 0,
          "discount": 0,
          "weighingwCount": 0,
          "arabicBarcodeName":
              ItemMasterCloneControllers.carabicController.text,
          "itemMasterCode": "",
          "lstAlterUnitDTO": [
            {
              "altBarcode": AlterUnitControllers.barcodeAltText.text,
              "altUnitId": int.parse(AlterUnitControllers.unitId.text),
              "altName": AlterUnitControllers.altName.text,
              "altContain": AlterUnitControllers.contain.text,
              "altCost": 0,
              "altSellingPrice": 0,
              "altRefCode": AlterUnitControllers.refcode.text,
              "altPluNo": AlterUnitControllers.pluno.text
            }
          ]
        });
      } else {
        body = jsonEncode({
          "itemMasterCode": "",
          "name": ItemMasterControllers.nameController.text,
          "shortName": ItemMasterControllers.shortNameController.text,
          "categoryId": categoryId,
          "sellingPrice":
              num.parse(ItemMasterControllers.sellingPController.text),
          "costPrice":
              num.parse(ItemMasterControllers.costPriceController.text),
          "barcode": barcode,
          "supplierItemCode": ItemMasterControllers.supplierController.text,
          "departmentId":
              int.parse(ItemMasterControllers.departmentController.text),
          "firstcategoryId": categoryId,
          "secondCategoryid": scategoryId,
          "colorId": 0,
          "sizeid": 0,
          "nonStockItem":
              (ItemMasterControllers.nonStockController.text.toLowerCase() ==
                  'true'),
          "counterStock": (ItemMasterControllers.counterStockController.text
                  .toLowerCase() ==
              'true'),
          "active":
              (ItemMasterControllers.activeController.text.toLowerCase() ==
                  'true'),
          "shelfNo": ItemMasterControllers.shelfNoController.text,
          "rackNo": ItemMasterControllers.rackNoController.text,
          "supplierCode": sCode,
          "arabicname": ItemMasterControllers.arabicController.text,
          "arabicBarcodeName": ItemMasterControllers.arabicController.text,
          "remarks": ItemMasterControllers.remarksController.text,
          "taxId": taxId,
          "createDate": ItemMasterControllers.createddateController.text,
          "createUser": UserControllers.nameController.text,
          "modDate": ItemMasterControllers.moddateController.text,
          "modUser": UserControllers.nameController.text,
          "itemMasterId": id ?? 0,
          "unitId": ItemMasterControllers.selectedunitController.text,
          "deviceName": deviceId,
          "userId": userId,
          "reorderLevel": 0,
          "reorderQty": 0,
          "weighingScaleItem": true,
          "basePrice": 0,
          "weighingItemType": 0,
          "foCitem": true,
          "sellingpricePackingUnit": 0,
          "discount": 0,
          "weighingwCount": 0,
          "delFlag": false,
          "itemGroup": "string",
          "loadItems": true,
        });
      }

      log(body);

      final response = await http.post(url, headers: headers, body: body);
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse["result"] == true) {
        final result = AddItems.fromJson(jsonResponse);
        log(response.body);
        return Right(result);
      } else if (response.statusCode == 400) {
        return const Left(MainFailure.serverFailure());
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on Error catch (e) {
      log(e.toString());
      if (e is http.ClientException) {
        return const Left(MainFailure.clientFailure());
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      // printAllControllerText();
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  // @override
  // Future<Either<MainFailure, AddItems>> updateToItemMaster() async {
  //   try {
  //     final endPoint = Hive.box("url").get('endpoint');
  //     final apiUrl = "$endPoint${ApiEndPoint.itemUpdateById}$id";
  //     final url = Uri.parse(apiUrl);
  //     final accessToken = Hive.box("token").get('api_token');
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessToken'
  //     };
  //     String barcode;
  //     if (ItemMasterControllers.barCodeController2.text.isEmpty) {
  //       barcode = ItemMasterControllers.barCodeController.text;
  //     } else {
  //       barcode = ItemMasterControllers.barCodeController2.text;
  //     }
  //     final body = jsonEncode({
  //       "itemMasterCode": 0,
  //       "name": ItemMasterControllers.nameController.text,
  //       "shortName": ItemMasterControllers.shortNameController.text,
  //       "categoryId": int.parse(ItemMasterControllers.categoryController.text),
  //       "unitId": 0,
  //       "sellingPrice":
  //           num.parse(ItemMasterControllers.sellingPController.text),
  //       "costPrice": num.parse(ItemMasterControllers.costPriceController.text),
  //       "barcode": barcode,
  //       "supplierItemCode": ItemMasterControllers.supplierController.text,
  //       "departmentId":
  //           int.parse(ItemMasterControllers.departmentController.text),
  //       "firstcategoryId":
  //           int.parse(ItemMasterControllers.categoryController.text),
  //       "secondCategoryid":
  //           int.parse(ItemMasterControllers.subCategoryController.text),
  //       "nonStockItem":
  //           (ItemMasterControllers.nonStockController.text.toLowerCase() ==
  //               'true'),
  //       "counterStock":
  //           (ItemMasterControllers.counterStockController.text.toLowerCase() ==
  //               'true'),
  //       "active": (ItemMasterControllers.activeController.text.toLowerCase() ==
  //           'true'),
  //       "shelfNo": ItemMasterControllers.shelfNoController.text,
  //       "rackNo": ItemMasterControllers.rackNoController.text,
  //       "supplierCode": ItemMasterControllers.supplierCodeController.text,
  //       "itemGroup": "d",
  //       "createDate": "2023-04-29T06:06:16.578Z",
  //       "createUser": "d",
  //       "modDate": "2023-04-29T06:06:16.578Z",
  //       "modUser": "d",
  //       "arabicname": ItemMasterControllers.arabicController.text,
  //       "remarks": ItemMasterControllers.remarksController.text,
  //       "arabicBarcodeName": "d",
  //       "taxId": int.parse(ItemMasterCloneControllers.cdefTaxId.text),
  //       "basePrice":
  //           num.parse(ItemMasterControllers.costWithTaxController.text),
  //       // "reorderLevel": 0,
  //       // "reorderQty": 0,
  //       "colorId": 0,
  //       "sizeid": 0,
  //       "foCitem": true,
  //       "sellingUnitId": 0,
  //       "leadtime": 0,
  //       "sellingpricePackingUnit": 0,
  //       "discount": 0,
  //       "weighingwCount": 0,
  //       "delFlag": true,
  //       "loadItems": true,
  //       "weighingScaleItem": true,
  //       "weighingItemType": 0
  //     });
  //     log(body);

  //     final response = await http.put(url, headers: headers, body: body);
  //     var jsonResponse = jsonDecode(response.body);
  //     print(jsonResponse);
  //     if (response.statusCode == 200 && jsonResponse["result"] == true) {
  //       final result = AddItems.fromJson(jsonResponse);
  //       log(response.body);
  //       return Right(result);
  //     } else if (response.statusCode == 400) {
  //       print("fail");
  //       return const Left(MainFailure.serverFailure());
  //     } else {
  //       return const Left(MainFailure.serverFailure());
  //     }
  //   } on Error catch (e) {
  //     log(e.toString());
  //     if (e is http.ClientException) {
  //       return const Left(MainFailure.clientFailure());
  //     } else {
  //       return const Left(MainFailure.serverFailure());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     return const Left(MainFailure.clientFailure());
  //   }
  // }

  // @override
  // Future<Either<MainFailure, AddItems>> addAlterBarCode() async {
  //   print(ItemMasterControllers.itemId.text);
  //   try {
  //     final endPoint = Hive.box("url").get('endpoint');
  //     final apiUrl = "$endPoint${ApiEndPoint.addAlterItems}";
  //     final url = Uri.parse(apiUrl);
  //     final accessToken = Hive.box("token").get('api_token');
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessToken'
  //     };
  //     final body = jsonEncode({
  //       "itemMasterId": ItemMasterControllers.itemId.text,
  //       // "itemMasterId": '',
  //       "sellingPrice": ItemMasterCloneControllers.csellingPController.text,
  //       "costPrice": ItemMasterCloneControllers.ccostPriceController.text,
  //       "barcode": AlterUnitControllers.barcodeAlt.text,
  //       // "weighingScaleItem": 1,
  //       // "unitId": 1,
  //       "contain": AlterUnitControllers.contain.text,
  //       // "cCode": 123,
  //       "altName": AlterUnitControllers.altName.text,
  //       "pluno": AlterUnitControllers.pluno.text,
  //       "refcode": AlterUnitControllers.refcode.text,
  //       "altitem": ""
  //     });
  //     log(body);

  //     final response = await http.post(url, headers: headers, body: body);
  //     var jsonResponse = jsonDecode(response.body);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final result = AddItems.fromJson(jsonResponse);
  //       log(response.body);
  //       return Right(result);
  //     } else if (response.statusCode == 400) {
  //       log(response.body);
  //       return const Left(MainFailure.serverFailure());
  //     } else {
  //       return const Left(MainFailure.serverFailure());
  //     }
  //   } on Error catch (e) {
  //     log(e.toString());
  //     if (e is http.ClientException) {
  //       return const Left(MainFailure.clientFailure());
  //     } else {
  //       return const Left(MainFailure.serverFailure());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     return const Left(MainFailure.clientFailure());
  //   }
  // }
}
