import 'package:dartz/dartz.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/login_model/login_model.dart';
import 'package:net_world_international/domain/userDetails_model/user_details_model/user_details_model.dart';

abstract class LoginServices {
  Future<Either<MainFailure, LoginModel>> getLoginData();

  Future<Either<MainFailure, UserDetailsModel>> getUserData();
}
