import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/domain/add_items_model.dart';
import 'package:net_world_international/domain/core/api_endPoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/get_items_model.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';

import 'package:net_world_international/domain/login_model/login_model.dart';
import 'package:net_world_international/domain/login_services.dart';
import 'package:http/http.dart' as http;
import 'package:net_world_international/domain/userDetails_model/user_details_model/user_details_model.dart';

@LazySingleton(as: LoginServices)
class LoginImp implements LoginServices {
  @override
  Future<Either<MainFailure, LoginModel>> getLoginData() async {
    try {
      final url = Uri.parse(ApiEndPoint.login);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'userName': LoginControllers.nameController.text,
        'password': LoginControllers.passWordController.text,
      });

      final response = await http.post(url, headers: headers, body: body);

      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = LoginModel.fromJson(jsonResponse);
        log(response.body);
        return Right(result);
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
  Future<Either<MainFailure, UserDetailsModel>> getUserData() async {
    try {
      final url = Uri.parse(ApiEndPoint.userDetails);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'userid': '1',
      });

      final response = await http.post(url, headers: headers, body: body);
      print(response.body);
      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = UserDetailsModel.fromJson(jsonResponse);
        // log(response.body);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, ItemGetConfig>> getItemConfig() async {
    try {
      final url = Uri.parse(ApiEndPoint.getItemConfig);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(
        url,
        headers: headers,
      );
      log(response.body);
      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = ItemGetConfig.fromJson(jsonResponse);
        // log(response.body);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, GetitemsModel>> getItems() async {
    try {
      final url = Uri.parse(ApiEndPoint.getItems);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(
        url,
        headers: headers,
      );
      print(response.body);
      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = GetitemsModel.fromJson(jsonResponse);
        // log(response.body);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

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
        "supplierItemCode": "d",
        "departmentId":
            int.parse(ItemMasterControllers.departmentController.text),
        "firstcategoryId":
            int.parse(ItemMasterControllers.categoryController.text),
        "secondCategoryid":
            int.parse(ItemMasterControllers.subCategoryController.text),
        "nonStockItem":
            (ItemMasterControllers.nonStockController.text.toLowerCase() ==
                'true'),
        "counterStock":
            (ItemMasterControllers.counterStockController.text.toLowerCase() ==
                'true'),
        "active": (ItemMasterControllers.activeController.text.toLowerCase() ==
            'true'),
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
      });

      print(body);

      final response = await http.post(url, headers: headers, body: body);

      //  log(response.data.toString());
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

  @override
  Future<Either<MainFailure, AddItems>> addAlterBarCode() async {
    try {
      final url = Uri.parse(ApiEndPoint.addAlterItems);
      final headers = {'Content-Type': 'application/json'};
      String barcode;
      // if (ItemMasterControllers.barCodeController2.text.isEmpty) {
      //   barcode = ItemMasterControllers.barCodeController.text;
      // } else {
      //   barcode = ItemMasterControllers.barCodeController2.text;
      // }
      print("s");
      print(int.parse(AlterUnitControllers.itemMasterCode.text));
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

      print(body);
      print("l");
      final response = await http.post(url, headers: headers, body: body);

      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = AddItems.fromJson(jsonResponse);
        log(response.body);
        return Right(result);
      } else if (response.statusCode == 400) {
        print(response.statusCode);
        print(response.body);

        return const Left(MainFailure.serverFailure());
      } else {
        print(response.statusCode);
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
