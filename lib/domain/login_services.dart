import 'package:dartz/dartz.dart';
import 'package:net_world_international/domain/add_items_model.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/get_items_model.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';

import 'package:net_world_international/domain/login_model/login_model.dart';
import 'package:net_world_international/domain/userDetails_model/user_details_model/user_details_model.dart';

abstract class LoginServices {
  Future<Either<MainFailure, LoginModel>> getLoginData();

  Future<Either<MainFailure, UserDetailsModel>> getUserData();

  Future<Either<MainFailure, ItemGetConfig>> getItemConfig();

  Future<Either<MainFailure, GetitemsModel>> getItems();

  Future<Either<MainFailure, AddItems>> addToItemMaster();
}
