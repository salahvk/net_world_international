import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/util/check_dep_name.dart';
import 'package:net_world_international/core/util/global_list.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/get_items_model.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';
import 'package:net_world_international/domain/services/item_services.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: ItemServices)
class ItemImp implements ItemServices {
  final String? itemId;
  dynamic state;
  ItemImp({this.itemId, this.state});
  @override
  Future<Either<MainFailure, ItemGetConfig>> getItemConfig() async {
    try {
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl = "$endPoint${ApiEndPoint.getItemConfig}";
      final url = Uri.parse(apiUrl);
      final accessToken = Hive.box("token").get('api_token');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      final response = await http.get(
        url,
        headers: headers,
      );
      // log(response.body);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = ItemGetConfig.fromJson(jsonResponse);
        print(jsonResponse['UnitList']);
        print(result.unitList);
        GlobalList().taxList.addAll(result.taxList ?? []);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      print("h");
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, GetitemsModel>> getItems() async {
    try {
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl = "$endPoint${ApiEndPoint.getItems}";
      final url = Uri.parse(apiUrl);
      final accessToken = Hive.box("token").get('api_token');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      final response = await http.get(
        url,
        headers: headers,
      );

      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = GetitemsModel.fromJson(jsonResponse);
        print("1");
        print(result.items);
        print("1");
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, Items>> getItemById() async {
    try {
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl = "$endPoint${ApiEndPoint.getEachItem}$itemId&Condition=g";
      final url = Uri.parse(apiUrl);
      final accessToken = Hive.box("token").get('api_token');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      var jsonResponse = jsonDecode(response.body);

      final result = Items.fromJson(jsonResponse);
      // log(response.body);
      print(result.barcode);
      ItemMasterCloneControllers.cdepartmentController.text =
          result.departmentId.toString() ?? '';
      ItemMasterCloneControllers.ccategoryController.text =
          result.categoryId.toString() ?? '';
      ItemMasterCloneControllers.csubCategoryController.text =
          result.secondCategoryid.toString() ?? '';
      ItemMasterCloneControllers.cdepartmentController.text =
          result.departmentId.toString() ?? '';
      // ItemMasterControllers.categoryController.text =
      //     result.categoryId.toString();
      ItemMasterCloneControllers.cdefTaxId.text = result.taxId.toString() ?? '';
      ItemMasterControllers.supplierController.text =
          result.supplierItemCode.toString() ?? '';
      ItemMasterCloneControllers.csupplierCodeController.text =
          result.supplierCode.toString() ?? '';
      ItemMasterControllers.itemId.text = itemId ?? '';
      // AlterUnitControllers.itemMasterCode.text = result.itemMasterCode ?? '';
      ItemMasterCloneControllers.cnameController.text = result.itemName ?? '';
      ItemMasterCloneControllers.cshortNameController.text =
          result.shortName ?? '';
      // ItemMasterCloneControllers.carabicController.text =
      //     result.arabicname ?? '';
      ItemMasterCloneControllers.cbarCodeController.text = result.barcode ?? '';
      ItemMasterControllers.barCodeController.text = result.barcode ?? '';
      ItemMasterCloneControllers.crackNoController.text = result.rackNo ?? '';
      ItemMasterCloneControllers.cshelfNoController.text = result.shelfNo ?? '';
      ItemMasterCloneControllers.ccostPriceController.text =
          result.costPrice.toString() ?? '';
      // log(ItemMasterCloneControllers.ccostPriceController.text);
      ItemMasterCloneControllers.csellingPController.text =
          result.sellingPrice.toString() ?? '';
      // ItemMasterCloneControllers.ccostWithTaxController.text =
      //     result.basePrice.toString();

      final departmentName = getDepNameById(
          result.departmentId ?? 0, state!.itemGetConfig!.departmentList!);
      ItemMasterCloneControllers.cdepartmentNameController.text =
          departmentName;

      final categoryName = getCategoryNameById(
          result.categoryId ?? 0, state!.itemGetConfig!.categoryList!);
      ItemMasterCloneControllers.ccategoryNameController.text = categoryName;

      final scategoryName = getSecondCategoryId(result.secondCategoryid ?? 0,
          state!.itemGetConfig!.secondCategoryList);
      ItemMasterCloneControllers.csubCategoryNameController.text =
          scategoryName;

      final supplierName = getSupplierNameById(result.supplierItemCode ?? '',
          state!.itemGetConfig!.supplierMasterList!);

      ItemMasterCloneControllers.csupplierNameController.text = supplierName;

      final taxName =
          getTaxNameById(result.taxId ?? 0, state!.itemGetConfig!.taxList!);
      ItemMasterCloneControllers.cdefTaxName.text = taxName;

      return Right(result);
    } catch (_) {}
    return const Left(MainFailure.clientFailure());
  }

  @override
  Future<Either<MainFailure, Items>> getItemByBar() async {
    try {
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl =
          "$endPoint${ApiEndPoint.getEachItem}${PrintControllers.barcode.text}";
      final url = Uri.parse(apiUrl);
      print(url);
      final accessToken = Hive.box("token").get('api_token');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      final response = await http.get(
        url,
        headers: headers,
      );

      var jsonResponse = jsonDecode(response.body);
      // log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = Items.fromJson(jsonResponse);
        PrintControllers.name.text = result.itemName ?? '';
        // PrintControllers.barcode.text = result.name ?? '';
        PrintControllers.sellingPrice.text =
            result.sellingPrice.toString() ?? '';
        PrintControllers.costPrice.text = result.costPrice.toString() ?? '';
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
