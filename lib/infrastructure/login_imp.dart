import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'package:injectable/injectable.dart';
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';

import 'package:net_world_international/domain/login_model/login_model.dart';
import 'package:net_world_international/domain/services/login_services.dart';
import 'package:http/http.dart' as http;
import 'package:net_world_international/domain/userDetails_model/user_details_model/user_details_model.dart';

@LazySingleton(as: LoginServices)
class LoginImp implements LoginServices {
  @override
  Future<Either<MainFailure, LoginModel>> getLoginData() async {
    try {
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl = "$endPoint${ApiEndPoint.login}";
      final url = Uri.parse(apiUrl);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'userName': LoginControllers.nameController.text,
        'password': LoginControllers.passWordController.text,
      });

      final response = await http.post(url, headers: headers, body: body);
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = LoginModel.fromJson(jsonResponse);
        // log(response.body);
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
      final endPoint = Hive.box("url").get('endpoint');
      final apiUrl = "$endPoint${ApiEndPoint.userDetails}";
      final url = Uri.parse(apiUrl);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'userid': '1',
      });

      final response = await http.post(url, headers: headers, body: body);
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = UserDetailsModel.fromJson(jsonResponse);
        return Right(result);
      } else {
        print("object1");
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print("S");
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
