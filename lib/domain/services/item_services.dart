import 'package:dartz/dartz.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';
import 'package:net_world_international/domain/get_items_model.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';
import 'package:net_world_international/domain/item_view_model.dart';

abstract class ItemServices {
  Future<Either<MainFailure, ItemGetConfig>> getItemConfig();
  Future<Either<MainFailure, GetitemsModel>> getItems();
  Future<Either<MainFailure, ItemViewById>> getItemById();
  Future<Either<MainFailure, ItemViewById>> getItemByBar();
}
