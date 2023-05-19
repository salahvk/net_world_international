import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/core/util/barcode_gen.dart';
import 'package:net_world_international/domain/core/api_endPoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/get_items_model.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';
import 'package:net_world_international/domain/login_model/login_model.dart';
import 'package:net_world_international/domain/userDetails_model/user_details_model/user_details_model.dart';
import 'package:net_world_international/infrastructure/login_api.dart';
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

        Either<MainFailure, GetitemsModel> items = await LoginImp().getItems();
        GetitemsModel getItems = items.getOrElse(() => GetitemsModel());
        print(getItems);
        if (loginModel.result?.message == 'Invalid user') {
          emit(Error());
        } else {
          Hive.box("token").put('api_token', loginModel.result?.token ?? '');
          Either<MainFailure, ItemGetConfig> result1 =
              await LoginImp().getItemConfig();
          ItemGetConfig itemGetConfig =
              result1.getOrElse(() => ItemGetConfig());
          String barcode1 = genBarcode(itemGetConfig);
          String barcode2 = genBarcode2(itemGetConfig);
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

        var uri = Uri.parse(ApiEndPoint.uploadImage);
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

        request.files.add(multipartFile);
        var response = await request.send();
        print(response);
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
            await LoginImp().getItemConfig();
        ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());
        String barcode1 = genBarcode(itemGetConfig);
        String barcode2 = genBarcode2(itemGetConfig);
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
        var uri = Uri.parse(ApiEndPoint.uploadImage);
        var map = <String, dynamic>{};
        final fName = EditProfileControllers.firstController.text;
        final lName = EditProfileControllers.lastController.text;
        map['name'] = "$fName $lName";
        map['userId'] = '1';

        http.Response response = await http.post(
          uri,
          body: map,
        );
        print(response);
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
            await LoginImp().getItemConfig();
        ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());
        String barcode1 = genBarcode(itemGetConfig);
        String barcode2 = genBarcode2(itemGetConfig);
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
              await LoginImp().getItemConfig();
          ItemGetConfig itemGetConfig =
              result1.getOrElse(() => ItemGetConfig());

          Either<MainFailure, GetitemsModel> items =
              await LoginImp().getItems();
          GetitemsModel getItems = items.getOrElse(() => GetitemsModel());

          await Future.delayed(const Duration(seconds: 3));
          String barcode1 = genBarcode(itemGetConfig);
          String barcode2 = genBarcode2(itemGetConfig);
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
          await LoginImp().getItemConfig();
      ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());

      final cuState = state;
      if (cuState is LoggedIn) {
        emit(LoggedIn(
            barCode1: cuState.barCode1,
            barCode2: cuState.barCode2,
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
        print("w");
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
      // emit(Loading());
      Either<MainFailure, UserDetailsModel> result =
          await LoginImp().getUserData();
      UserDetailsModel userDetailsModel =
          result.getOrElse(() => UserDetailsModel());

      Either<MainFailure, ItemGetConfig> result1 =
          await LoginImp().getItemConfig();
      ItemGetConfig itemGetConfig = result1.getOrElse(() => ItemGetConfig());

      Either<MainFailure, GetitemsModel> items = await LoginImp().getItems();
      GetitemsModel getItems = items.getOrElse(() => GetitemsModel());

      String barcode1 = genBarcode(itemGetConfig);
      String barcode2 = genBarcode2(itemGetConfig);
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

      final url = Uri.parse("${ApiEndPoint.getItems}?page=$pageNumber");
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
        if (cuState is OptionPageState) {
          emit(OptionPageState(
              loginModel: cuState.loginModel,
              userModel: cuState.userModel,
              barCode1: cuState.barCode1,
              barCode2: cuState.barCode2,
              getItems: result,
              itemGetConfig: cuState.itemGetConfig));
        }
      }

      // if (cuState is LoggedIn) {
      //   print("w");
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // } else if (cuState is HomePageState) {
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // } else if (cuState is ProfilePageState) {
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // } else if (cuState is OptionPageState) {
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // }
    });

    on<NextBarCodeEvent>((event, emit) async {
      final cuState = state;
      try {
        final url = Uri.parse(ApiEndPoint.getNextItem);
        final headers = {'Content-Type': 'application/json'};
        final body = jsonEncode(
            {"barcode": event.barcode, "selectrow": event.selectedThrow});

        final response = await http.post(url, headers: headers, body: body);

        //  log(response.data.toString());
        var jsonResponse = jsonDecode(response.body);
        ItemMasterControllers.barCodeController2.text = jsonResponse["barcode"];
        print(jsonResponse["barcode"]);
        if (cuState is OptionPageState) {
          emit(OptionPageState(
              loginModel: cuState.loginModel,
              userModel: cuState.userModel,
              barCode1: cuState.barCode1,
              barCode2: cuState.barCode2,
              getItems: cuState.getItems,
              itemGetConfig: cuState.itemGetConfig));
        }
      } catch (_) {
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
      // if (cuState is LoggedIn) {
      //   print("w");
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // } else if (cuState is HomePageState) {
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // } else if (cuState is ProfilePageState) {
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // } else if (cuState is OptionPageState) {
      //   emit(ProfilePageState(
      //       loginModel: cuState.loginModel, userModel: cuState.userModel));
      // }
    });
  }
}
