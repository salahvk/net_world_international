import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/domain/core/api_endPoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
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

        Either<MainFailure, LoginModel> result =
            await LoginImp().getLoginData();
        Either<MainFailure, UserDetailsModel> userData =
            await LoginImp().getUserData();

        LoginModel loginModel = result.fold(
          (failure) {
            emit(Error());
            // handle the failure case here
            return LoginModel(); // or some default value
          },
          (model) => model,
        );

        UserDetailsModel userModel = userData.fold(
          (failure) {
            emit(Error());
            // handle the failure case here
            return UserDetailsModel(); // or some default value
          },
          (model) => model,
        );

        if (loginModel.result?.message == 'Invalid user') {
          emit(Error());
        } else {
          Hive.box("token").put('api_token', loginModel.result?.token ?? '');
          emit(LoggedIn(loginModel: loginModel, userModel: userModel));
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
        emit(LoggedIn(
          userModel: userModel,
        ));
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
        emit(LoggedIn(
          userModel: userModel,
        ));
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
          Either<MainFailure, UserDetailsModel> userData =
              await LoginImp().getUserData();

          UserDetailsModel userModel = userData.fold(
            (failure) {
              return UserDetailsModel();
            },
            (model) => model,
          );
          await Future.delayed(const Duration(seconds: 3));
          emit(LoggedIn(userModel: userModel));
        }
      } catch (_) {}
    });
    // on<LoggedOutEvent>((event, emit) {
    //   try {} catch (_) {}
    // });
  }
}
