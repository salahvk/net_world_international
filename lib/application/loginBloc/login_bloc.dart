import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/util/barcode_gen.dart';
import 'package:net_world_international/core/util/check_dep_name.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/get_items_model.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';
import 'package:net_world_international/domain/item_view_model.dart';
import 'package:net_world_international/domain/login_model/login_model.dart';
import 'package:net_world_international/domain/userDetails_model/user_details_model/user_details_model.dart';
import 'package:net_world_international/infrastructure/item_imp.dart';
import 'package:net_world_international/infrastructure/login_imp.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(Initial()) {
    on<NavigateToMainScreenEvent>((event, emit) async {
      try {
        emit(Loading());

        // Get Login data
        Either<MainFailure, LoginModel> result =
            await LoginImp().getLoginData();
        LoginModel loginModel = result.getOrElse(() => LoginModel());

        // Get User data
        Either<MainFailure, UserDetailsModel> userData =
            await LoginImp().getUserData();
        UserDetailsModel userModel =
            userData.getOrElse(() => UserDetailsModel());

        Either<MainFailure, GetitemsModel> items = await ItemImp().getItems();
        GetitemsModel getItems = items.getOrElse(() => GetitemsModel());
        if (loginModel.result?.message == 'Invalid user') {
          emit(Error());
        } else {
          Hive.box("token").put('api_token', loginModel.result?.token ?? '');
          Hive.box("token").put('user_id', loginModel.userId ?? '');
          Either<MainFailure, ItemGetConfig> result1 =
              await ItemImp().getItemConfig();
          ItemGetConfig itemGetConfig =
              result1.getOrElse(() => ItemGetConfig());
          String barcode1 = await genBarcode(itemGetConfig);
          String barcode2 = await genBarcode2(itemGetConfig);
          // itemGetConfig.;

          emit(LoggedIn(
              loginModel: loginModel,
              userModel: userModel,
              itemGetConfig: itemGetConfig,
              barCode1: barcode1,
              barCode2: barcode2,
              getItems: getItems));
        }
      } catch (_) {}
    });

    on<UpdateProfilePicEvent>((event, emit) async {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image == null) {
          return;
        }
        emit(Loading());

        var stream = http.ByteStream(DelegatingStream(image.openRead()));
        var length = await image.length();
        final endPoint = Hive.box("url").get('endpoint');
        final accessToken = Hive.box("token").get('api_token');

        final apiUrl = "$endPoint${ApiEndPoint.uploadImage}";
        var uri = Uri.parse(apiUrl);
        var request = http.MultipartRequest(
          "POST",
          uri,
        );
        var multipartFile = http.MultipartFile(
          'file',
          stream,
          length,
          filename: (image.path),
        );

        request.fields['userId'] = '1';
        request.headers['Authorization'] = 'Bearer $accessToken';

        request.files.add(multipartFile);
        await request.send();

        Either<MainFailure, UserDetailsModel> userData =
            await LoginImp().getUserData();
        UserDetailsModel userModel = userData.fold(
          (failure) {
            emit(Error());

            return UserDetailsModel();
          },
          (model) => model,
        );
        Either<MainFailure, ItemGetConfig> result1 =
            await ItemImp().getItemConfig();
        ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());
        String barcode1 = await genBarcode(itemGetConfig);
        String barcode2 = await genBarcode2(itemGetConfig);
        emit(LoggedIn(
            userModel: userModel,
            itemGetConfig: itemGetConfig,
            barCode1: barcode1,
            barCode2: barcode2));
      } catch (_) {}
    });
    on<UpdateNameEvent>((event, emit) async {
      try {
        emit(Loading());
        final endPoint = Hive.box("url").get('endpoint');
        final apiUrl = "$endPoint${ApiEndPoint.uploadImage}";
        var uri = Uri.parse(apiUrl);
        var map = <String, dynamic>{};
        final fName = EditProfileControllers.firstController.text;
        final lName = EditProfileControllers.lastController.text;
        map['name'] = "$fName $lName";
        map['userId'] = '1';
        final accessToken = Hive.box("token").get('api_token');
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        };

        await http.post(uri, body: map, headers: headers);

        Either<MainFailure, UserDetailsModel> userData =
            await LoginImp().getUserData();
        UserDetailsModel userModel = userData.fold(
          (failure) {
            emit(Error());

            return UserDetailsModel();
          },
          (model) => model,
        );
        Either<MainFailure, ItemGetConfig> result1 =
            await ItemImp().getItemConfig();
        ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());
        String barcode1 = await genBarcode(itemGetConfig);
        String barcode2 = await genBarcode2(itemGetConfig);
        emit(LoggedIn(
            userModel: userModel,
            itemGetConfig: itemGetConfig,
            barCode1: barcode1,
            barCode2: barcode2));
      } catch (_) {}
    });
    on<NavigateToHomeScreenEvent>((event, emit) async {
      try {
        emit(Loading());

        final apiToken = Hive.box("token").get('api_token');
        if (apiToken == null) {
          await Future.delayed(const Duration(seconds: 3));
          emit(LoggedOut());
        } else {
          Either<MainFailure, UserDetailsModel> result =
              await LoginImp().getUserData();
          UserDetailsModel userDetailsModel =
              result.getOrElse(() => UserDetailsModel());

          Either<MainFailure, ItemGetConfig> result1 =
              await ItemImp().getItemConfig();
          ItemGetConfig itemGetConfig =
              result1.getOrElse(() => ItemGetConfig());

          Either<MainFailure, GetitemsModel> items = await ItemImp().getItems();
          GetitemsModel getItems = items.getOrElse(() => GetitemsModel());

          await Future.delayed(const Duration(seconds: 3));
          String barcode1 = await genBarcode(itemGetConfig);
          String barcode2 = await genBarcode2(itemGetConfig);
          emit(LoggedIn(
              userModel: userDetailsModel,
              itemGetConfig: itemGetConfig,
              barCode1: barcode1,
              barCode2: barcode2,
              getItems: getItems));
        }
      } catch (_) {}
    });
    on<AddToItemMasterEvent>((event, emit) async {
      Either<MainFailure, ItemGetConfig> result1 =
          await ItemImp().getItemConfig();
      ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());

      final cuState = state;
      String barcode1 = await genBarcode(itemGetConfig);
      String barcode2 = await genBarcode2(itemGetConfig);

      if (cuState is LoggedIn) {
        emit(LoggedIn(
            barCode1: barcode1,
            barCode2: barcode2,
            getItems: cuState.getItems,
            itemGetConfig: itemGetConfig,
            loginModel: cuState.loginModel,
            userModel: cuState.userModel));
      }
    });

    on<HomePageEvent>((event, emit) async {
      final cuState = state;
      if (cuState is LoggedIn) {
        emit(HomePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      } else if (cuState is HomePageState) {
        emit(HomePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      } else if (cuState is ProfilePageState) {
        emit(HomePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      } else if (cuState is OptionPageState) {
        emit(HomePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      }
    });

    on<ProfilePageEvent>((event, emit) async {
      final cuState = state;
      if (cuState is LoggedIn) {
        emit(ProfilePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      } else if (cuState is HomePageState) {
        emit(ProfilePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      } else if (cuState is ProfilePageState) {
        emit(ProfilePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      } else if (cuState is OptionPageState) {
        emit(ProfilePageState(
            loginModel: cuState.loginModel, userModel: cuState.userModel));
      }
    });

    on<OptionPageEvent>((event, emit) async {
      Either<MainFailure, ItemGetConfig> result1 =
          await ItemImp().getItemConfig();
      ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());

      Either<MainFailure, GetitemsModel> items = await ItemImp().getItems();
      GetitemsModel getItems = items.getOrElse(() => GetitemsModel());

      String barcode1 = await genBarcode(itemGetConfig);
      String barcode2 = await genBarcode2(itemGetConfig);
      final cuState = state;
      if (cuState is LoggedIn) {
        emit(OptionPageState(
            loginModel: cuState.loginModel,
            userModel: cuState.userModel,
            barCode1: barcode1,
            barCode2: barcode2,
            getItems: getItems,
            itemGetConfig: itemGetConfig));
      } else if (cuState is HomePageState) {
        emit(OptionPageState(
            loginModel: cuState.loginModel,
            userModel: cuState.userModel,
            barCode1: barcode1,
            barCode2: barcode2,
            getItems: getItems,
            itemGetConfig: itemGetConfig));
      } else if (cuState is ProfilePageState) {
        emit(OptionPageState(
            loginModel: cuState.loginModel,
            userModel: cuState.userModel,
            barCode1: barcode1,
            barCode2: barcode2,
            getItems: getItems,
            itemGetConfig: itemGetConfig));
      } else if (cuState is OptionPageState) {
        emit(OptionPageState(
            loginModel: cuState.loginModel,
            userModel: cuState.userModel,
            barCode1: barcode1,
            barCode2: barcode2,
            getItems: getItems,
            itemGetConfig: itemGetConfig));
      }
    });
    on<GetNewItemsEvent>((event, emit) async {
      final cuState = state;

      String? pageNumber = event.pageNumber.toString();
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl = "$endPoint${ApiEndPoint.getItems}?page=$pageNumber";
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

      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = GetitemsModel.fromJson(jsonResponse);
        bool isEmpty = false;

        if (result.items!.isEmpty) {
          isEmpty = true;
        }

        if (cuState is OptionPageState) {
          emit(OptionPageState(
            isEmpty: isEmpty,
            loginModel: cuState.loginModel,
            userModel: cuState.userModel,
            barCode1: cuState.barCode1,
            barCode2: cuState.barCode2,
            getItems: result,
            itemGetConfig: cuState.itemGetConfig,
          ));
        }
      }
    });

    on<NextBarCodeEvent>((event, emit) async {
      final cuState = state;
      try {
        final endPoint = Hive.box("url").get('endpoint');
        final apiUrl = "$endPoint${ApiEndPoint.getNextItem}";
        final url = Uri.parse(apiUrl);
        final accessToken = Hive.box("token").get('api_token');
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        };
        final body = jsonEncode(
            {"barcode": event.barcode, "selectrow": event.selectedThrow});

        final response = await http.post(url, headers: headers, body: body);

        var jsonResponse = jsonDecode(response.body);
        log(response.body);
        final result = ItemViewById.fromJson(jsonResponse);
        ItemMasterControllers.barCodeController2.text =
            result.items?.barcode ?? '';
        ItemMasterControllers.nameController.text = result.items?.name ?? '';
        ItemMasterControllers.shortNameController.text =
            result.items?.shortName ?? '';
        // ItemMasterControllers.arabicController.text = result.arabicname ?? '';
        ItemMasterControllers.rackNoController.text =
            result.items?.rackNo ?? '';
        ItemMasterControllers.shelfNoController.text =
            result.items?.shelfNo ?? '';
        ItemMasterControllers.departmentController.text =
            result.items?.departmentId.toString() ?? '';
        ItemMasterControllers.categoryController.text =
            result.items?.categoryId.toString() ?? '';
        ItemMasterControllers.subCategoryController.text =
            result.items?.secondCategoryid.toString() ?? '';
        ItemMasterControllers.supplierController.text =
            result.items?.supplierItemCode.toString() ?? '';
        ItemMasterControllers.costPriceController.text =
            result.items?.costPrice.toString() ?? '';
        ItemMasterControllers.sellingPController.text =
            result.items?.sellingPrice.toString() ?? '';
        // ItemMasterControllers.costWithTaxController.text =
        //     result.basePrice.toString();
        ItemMasterControllers.supplierCodeController.text =
            result.items?.suppliercode ?? '';
        ItemMasterControllers.itemId.text = result.items?.id.toString() ?? '';
        ItemMasterControllers.barCodeController.text =
            ItemMasterControllers.barCodeController2.text;
        //
        // ItemMasterControllers.nonStockController.text = result.nonStockItem.toString() == 1 ? true : false;
        //  "nonStockItem":
        //     (ItemMasterControllers.nonStockController.text.toLowerCase() ==
        //         'true'),
        // "counterStock":
        //     (ItemMasterControllers.counterStockController.text.toLowerCase() ==
        //         'true'),
        // "active": (ItemMasterControllers.activeController.text.toLowerCase() ==
        //     'true'),
        //
        ItemMasterCloneControllers.cdefTaxId.text =
            result.items?.taxId.toString() ?? '';

        if (cuState is OptionPageState) {
          final departmentName = getDepNameById(result.items?.departmentId,
              cuState.itemGetConfig!.departmentList!);
          ItemMasterControllers.departmentNameController.text = departmentName;

          final categoryName = getCategoryNameById(
              result.items?.categoryId, cuState.itemGetConfig!.categoryList!);
          ItemMasterControllers.categoryNameController.text = categoryName;

          final subcategoryName = getSecondCategoryId(
              result.items?.secondCategoryid,
              cuState.itemGetConfig!.secondCategoryList!);
          ItemMasterControllers.subCategoryNameController.text =
              subcategoryName;

          final supplierName = getSupplierNameById(
              result.items?.supplierItemCode ?? '',
              cuState.itemGetConfig!.supplierMasterList!);
          ItemMasterControllers.supplierNameController.text = supplierName;
          emit(OptionPageState(
              loginModel: cuState.loginModel,
              userModel: cuState.userModel,
              barCode1: cuState.barCode1,
              barCode2: cuState.barCode2,
              getItems: cuState.getItems,
              itemGetConfig: cuState.itemGetConfig,
              itemViewById: result));
        }
      } catch (e) {
        print(e);
        ItemMasterControllers.barCodeController2.text = '4321';
        if (cuState is OptionPageState) {
          emit(OptionPageState(
              loginModel: cuState.loginModel,
              userModel: cuState.userModel,
              barCode1: cuState.barCode1,
              barCode2: cuState.barCode2,
              getItems: cuState.getItems,
              itemGetConfig: cuState.itemGetConfig));
        }
      }
    });

    on<SearchBarcodeEvent>((event, emit) async {
      final cuState = state;
      try {
        final endPoint = Hive.box("url").get('endpoint');
        final apiUrl =
            "$endPoint${ApiEndPoint.itemByBarcode}${ItemMasterControllers.barCodeController.text}";
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
        log(response.body);
        final result = ItemViewById.fromJson(jsonResponse);
        print(result.items?.barcode);
        ItemMasterControllers.barCodeController2.text =
            result.items?.barcode ?? '';
        ItemMasterControllers.nameController.text = result.items?.name ?? '';
        ItemMasterControllers.shortNameController.text =
            result.items?.shortName ?? '';
        // ItemMasterControllers.arabicController.text = result.arabicname ?? '';
        ItemMasterControllers.rackNoController.text =
            result.items?.rackNo ?? '';
        ItemMasterControllers.shelfNoController.text =
            result.items?.shelfNo ?? '';
        ItemMasterControllers.departmentController.text =
            result.items?.departmentId.toString() ?? '';
        ItemMasterControllers.categoryController.text =
            result.items?.categoryId.toString() ?? '';
        ItemMasterControllers.subCategoryController.text =
            result.items?.secondCategoryid.toString() ?? '';
        ItemMasterControllers.supplierController.text =
            result.items?.supplierItemCode.toString() ?? '';
        ItemMasterControllers.costPriceController.text =
            result.items?.costPrice.toString() ?? '';
        ItemMasterControllers.sellingPController.text =
            result.items?.sellingPrice.toString() ?? '';
        // ItemMasterControllers.costWithTaxController.text =
        //     result.basePrice.toString();
        ItemMasterControllers.supplierCodeController.text =
            result.items?.suppliercode ?? '';
        ItemMasterControllers.itemId.text = result.items?.id.toString() ?? '';
        ItemMasterControllers.barCodeController.text =
            ItemMasterControllers.barCodeController2.text;
        //
        // ItemMasterControllers.nonStockController.text = result.nonStockItem.toString() == 1 ? true : false;
        //  "nonStockItem":
        //     (ItemMasterControllers.nonStockController.text.toLowerCase() ==
        //         'true'),
        // "counterStock":
        //     (ItemMasterControllers.counterStockController.text.toLowerCase() ==
        //         'true'),
        // "active": (ItemMasterControllers.activeController.text.toLowerCase() ==
        //     'true'),
        //
        ItemMasterCloneControllers.cdefTaxId.text =
            result.items?.taxId.toString() ?? '';

        if (cuState is OptionPageState) {
          final departmentName = getDepNameById(result.items?.departmentId,
              cuState.itemGetConfig!.departmentList!);
          ItemMasterControllers.departmentNameController.text = departmentName;

          final categoryName = getCategoryNameById(
              result.items?.categoryId, cuState.itemGetConfig!.categoryList!);
          ItemMasterControllers.categoryNameController.text = categoryName;

          final subcategoryName = getSecondCategoryId(
              result.items?.secondCategoryid,
              cuState.itemGetConfig!.secondCategoryList!);
          ItemMasterControllers.subCategoryNameController.text =
              subcategoryName;

          final supplierName = getSupplierNameById(
              result.items?.supplierItemCode ?? '',
              cuState.itemGetConfig!.supplierMasterList!);
          ItemMasterControllers.supplierNameController.text = supplierName;
          emit(OptionPageState(
              loginModel: cuState.loginModel,
              userModel: cuState.userModel,
              barCode1: cuState.barCode1,
              barCode2: cuState.barCode2,
              getItems: cuState.getItems,
              itemGetConfig: cuState.itemGetConfig,
              itemViewById: result));
        }
      } catch (e) {
        // print(e);
        // ItemMasterControllers.barCodeController2.text = '4321';
        if (cuState is OptionPageState) {
          emit(OptionPageState(
              loginModel: cuState.loginModel,
              userModel: cuState.userModel,
              barCode1: cuState.barCode1,
              barCode2: cuState.barCode2,
              getItems: cuState.getItems,
              itemGetConfig: cuState.itemGetConfig));
        }
      }
    });
  }
}
