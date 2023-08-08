import 'package:net_world_international/domain/item_config/item_config.dart';

class GlobalList {
  static final GlobalList _instance = GlobalList._internal();

  List<TaxList> taxList = [];

  factory GlobalList() {
    return _instance;
  }

  GlobalList._internal();
}
