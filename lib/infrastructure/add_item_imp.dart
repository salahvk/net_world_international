import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/domain/add_items_model.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/services/add_item_services.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: AddItemServices)
class AddItemImp implements AddItemServices {
  final String? id;

  AddItemImp({this.id});

  @override
  Future<Either<MainFailure, AddItems>> addToItemMaster() async {
    try {
      final url = Uri.parse(ApiEndPoint.addItems);
      final headers = {'Content-Type': 'application/json'};
      String barcode;
      if (ItemMasterControllers.barCodeController2.text.isEmpty) {
        barcode = ItemMasterControllers.barCodeController.text;
      } else {
        barcode = ItemMasterControllers.barCodeController2.text;
      }
      final body = jsonEncode({
        "itemMasterCode": barcode,
        "name": ItemMasterControllers.nameController.text,
        "shortName": ItemMasterControllers.shortNameController.text,
        "categoryId": int.parse(ItemMasterControllers.categoryController.text),
        "unitId": 0,
        "sellingPrice":
            num.parse(ItemMasterControllers.sellingPController.text),
        "costPrice": num.parse(ItemMasterControllers.costPriceController.text),
        "barcode": barcode,
        "supplierItemCode": ItemMasterControllers.supplierController.text,
        "departmentId":
            int.parse(ItemMasterControllers.departmentController.text),
        "firstcategoryId":
            int.parse(ItemMasterControllers.categoryController.text),
        "secondCategoryid":
            int.parse(ItemMasterControllers.subCategoryController.text),
        "nonStockItem": false,
        // (ItemMasterControllers.nonStockController.text.toLowerCase() ==
        //     'true'),
        "counterStock": false,
        // (ItemMasterControllers.counterStockController.text.toLowerCase() ==
        //     'true'),
        // "active": (ItemMasterControllers.activeController.text.toLowerCase() ==
        //     'true'),
        "shelfNo": ItemMasterControllers.shelfNoController.text,
        "rackNo": ItemMasterControllers.rackNoController.text,
        "supplierCode": ItemMasterControllers.supplierCodeController.text,
        "itemGroup": "d",
        "createDate": "2023-04-29T06:06:16.578Z",
        "createUser": "d",
        "modDate": "2023-04-29T06:06:16.578Z",
        "modUser": "d",
        "arabicname": ItemMasterControllers.arabicController.text,
        "remarks": ItemMasterControllers.remarksController.text,
        "arabicBarcodeName": "d",
        "taxId": int.parse(ItemMasterCloneControllers.cdefTaxId.text),
        "basePrice":
            num.parse(ItemMasterControllers.costWithTaxController.text),
        // "reorderLevel": 0,
        // "reorderQty": 0,
        "colorId": 0,
        "sizeid": 0,
        "foCitem": true,
        "sellingUnitId": 0,
        "leadtime": 0,
        "sellingpricePackingUnit": 0,
        "discount": 0,
        "weighingwCount": 0,
        "delFlag": true,
        "loadItems": true,
        "weighingScaleItem": true,
        "weighingItemType": 0
      });
      log(body);

      final response = await http.post(url, headers: headers, body: body);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200 && jsonResponse["result"] == true) {
        final result = AddItems.fromJson(jsonResponse);
        log(response.body);
        return Right(result);
      } else if (response.statusCode == 400) {
        print("fail");
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
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, AddItems>> updateToItemMaster() async {
    try {
      final url = Uri.parse("${ApiEndPoint.itemUpdateById}$id");
      final headers = {'Content-Type': 'application/json'};
      String barcode;
      if (ItemMasterControllers.barCodeController2.text.isEmpty) {
        barcode = ItemMasterControllers.barCodeController.text;
      } else {
        barcode = ItemMasterControllers.barCodeController2.text;
      }
      final body = jsonEncode({
        "itemMasterCode": barcode,
        "name": ItemMasterControllers.nameController.text,
        "shortName": ItemMasterControllers.shortNameController.text,
        "categoryId": int.parse(ItemMasterControllers.categoryController.text),
        "unitId": 0,
        "sellingPrice":
            num.parse(ItemMasterControllers.sellingPController.text),
        "costPrice": num.parse(ItemMasterControllers.costPriceController.text),
        "barcode": barcode,
        "supplierItemCode": ItemMasterControllers.supplierController.text,
        "departmentId":
            int.parse(ItemMasterControllers.departmentController.text),
        "firstcategoryId":
            int.parse(ItemMasterControllers.categoryController.text),
        "secondCategoryid":
            int.parse(ItemMasterControllers.subCategoryController.text),
        "nonStockItem": false,
        // (ItemMasterControllers.nonStockController.text.toLowerCase() ==
        //     'true'),
        "counterStock": false,
        // (ItemMasterControllers.counterStockController.text.toLowerCase() ==
        //     'true'),
        // "active": (ItemMasterControllers.activeController.text.toLowerCase() ==
        //     'true'),
        "shelfNo": ItemMasterControllers.shelfNoController.text,
        "rackNo": ItemMasterControllers.rackNoController.text,
        "supplierCode": ItemMasterControllers.supplierCodeController.text,
        "itemGroup": "d",
        "createDate": "2023-04-29T06:06:16.578Z",
        "createUser": "d",
        "modDate": "2023-04-29T06:06:16.578Z",
        "modUser": "d",
        "arabicname": ItemMasterControllers.arabicController.text,
        "remarks": ItemMasterControllers.remarksController.text,
        "arabicBarcodeName": "d",
        "taxId": int.parse(ItemMasterCloneControllers.cdefTaxId.text),
        "basePrice":
            num.parse(ItemMasterControllers.costWithTaxController.text),
        // "reorderLevel": 0,
        // "reorderQty": 0,
        "colorId": 0,
        "sizeid": 0,
        "foCitem": true,
        "sellingUnitId": 0,
        "leadtime": 0,
        "sellingpricePackingUnit": 0,
        "discount": 0,
        "weighingwCount": 0,
        "delFlag": true,
        "loadItems": true,
        "weighingScaleItem": true,
        "weighingItemType": 0
      });
      log(body);

      final response = await http.put(url, headers: headers, body: body);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200 && jsonResponse["result"] == true) {
        final result = AddItems.fromJson(jsonResponse);
        log(response.body);
        return Right(result);
      } else if (response.statusCode == 400) {
        print("fail");
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
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, AddItems>> addAlterBarCode() async {
    try {
      final url = Uri.parse(ApiEndPoint.addAlterItems);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        "itemMasterId": int.parse(AlterUnitControllers.itemMasterCode.text),
        "sellingPrice": ItemMasterCloneControllers.csellingPController.text,
        "costPrice": ItemMasterCloneControllers.ccostPriceController.text,
        "barcode": AlterUnitControllers.barcodeAlt.text,
        // "weighingScaleItem": 1,
        // "unitId": 1,
        "contain": AlterUnitControllers.contain.text,
        // "cCode": 123,
        "altName": AlterUnitControllers.altName.text,
        "pluno": AlterUnitControllers.pluno.text,
        "refcode": AlterUnitControllers.refcode.text
      });

      final response = await http.post(url, headers: headers, body: body);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
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
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
