import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/util/check_dep_name.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/get_items_model.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';
import 'package:net_world_international/domain/item_view_model.dart';
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
      final url = Uri.parse(ApiEndPoint.getItemConfig);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(
        url,
        headers: headers,
      );
      log(response.body);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = ItemGetConfig.fromJson(jsonResponse);
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
  Future<Either<MainFailure, GetitemsModel>> getItems() async {
    try {
      final url = Uri.parse(ApiEndPoint.getItems);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(
        url,
        headers: headers,
      );

      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = GetitemsModel.fromJson(jsonResponse);
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
  Future<Either<MainFailure, ItemViewById>> getItemById() async {
    try {
      final url = Uri.parse("${ApiEndPoint.getItemById}$itemId");
      final headers = {'Content-Type': 'application/json'};

      final response = await http.get(
        url,
        headers: headers,
      );

      var jsonResponse = jsonDecode(response.body);
      final result = ItemViewById.fromJson(jsonResponse);
      log(response.body);
      ItemMasterCloneControllers.cdepartmentController.text =
          result.departmentId.toString();
      ItemMasterCloneControllers.ccategoryController.text =
          result.categoryId.toString();
      ItemMasterCloneControllers.csubCategoryController.text =
          result.secondCategoryid.toString();
      ItemMasterCloneControllers.cdepartmentController.text =
          result.departmentId.toString();
      // ItemMasterControllers.categoryController.text =
      //     result.categoryId.toString();
      ItemMasterCloneControllers.cdefTaxId.text = result.taxId.toString();
      ItemMasterControllers.supplierController.text =
          result.supplierItemCode.toString();
      ItemMasterCloneControllers.csupplierCodeController.text =
          result.suppliercode.toString();
      ItemMasterControllers.itemId.text = itemId ?? '';
      AlterUnitControllers.itemMasterCode.text = result.itemMasterCode ?? '';
      ItemMasterCloneControllers.cnameController.text = result.name ?? '';
      ItemMasterCloneControllers.cshortNameController.text =
          result.shortName ?? '';
      ItemMasterCloneControllers.carabicController.text =
          result.arabicname ?? '';
      ItemMasterCloneControllers.cbarCodeController.text = result.barcode ?? '';
      ItemMasterControllers.barCodeController.text = result.barcode ?? '';
      ItemMasterCloneControllers.crackNoController.text = result.rackNo ?? '';
      ItemMasterCloneControllers.cshelfNoController.text = result.shelfNo ?? '';
      ItemMasterCloneControllers.ccostPriceController.text =
          result.costPrice.toString();
      ItemMasterCloneControllers.csellingPController.text =
          result.sellingPrice.toString();
      ItemMasterCloneControllers.ccostWithTaxController.text =
          result.basePrice.toString();

      final departmentName = getDepNameById(
          result.departmentId, state!.itemGetConfig!.departmentList!);
      ItemMasterCloneControllers.cdepartmentNameController.text =
          departmentName;

      final categoryName = getCategoryNameById(
          result.categoryId, state!.itemGetConfig!.categoryList!);
      ItemMasterCloneControllers.ccategoryNameController.text = categoryName;

      final scategoryName = getSecondCategoryId(
          result.secondCategoryid, state!.itemGetConfig!.secondCategoryList);
      ItemMasterCloneControllers.csubCategoryNameController.text =
          scategoryName;

      final supplierName = getSupplierNameById(result.supplierItemCode ?? '',
          state!.itemGetConfig!.supplierMasterList!);

      ItemMasterCloneControllers.csupplierNameController.text = supplierName;

      final taxName =
          getTaxNameById(result.taxId ?? '', state!.itemGetConfig!.taxList!);
      ItemMasterCloneControllers.cdefTaxName.text = taxName;

      return Right(result);
    } catch (_) {}
    return const Left(MainFailure.clientFailure());
  }

  @override
  Future<Either<MainFailure, ItemViewById>> getItemByBar() async {
    try {
      final url = Uri.parse(
          "${ApiEndPoint.itemByBarcode}${PrintControllers.barcode.text}");
      print(url);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(
        url,
        headers: headers,
      );

      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = ItemViewById.fromJson(jsonResponse);
        PrintControllers.name.text = result.name ?? '';
        // PrintControllers.barcode.text = result.name ?? '';
        PrintControllers.sellingPrice.text = result.sellingPrice.toString();
        PrintControllers.costPrice.text = result.costPrice.toString();
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
