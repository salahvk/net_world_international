import 'package:dartz/dartz.dart';
import 'package:net_world_international/domain/add_items_model.dart';
import 'package:net_world_international/domain/failures/main_failures.dart';

abstract class AddItemServices {
  Future<Either<MainFailure, AddItems>> addToItemMaster();
  Future<Either<MainFailure, AddItems>> updateToItemMaster();
  Future<Either<MainFailure, AddItems>> addAlterBarCode();
}
