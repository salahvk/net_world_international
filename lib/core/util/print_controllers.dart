import 'package:net_world_international/core/controllers/controllers.dart';

void printAllControllerText() {
  print(' ${ItemMasterControllers.itemId.text}');
  print(' ${ItemMasterControllers.activeController.text}');
  print(' ${ItemMasterControllers.nonStockController.text}');
  print(' ${ItemMasterControllers.sellingPController.text}');
  print(' ${ItemMasterControllers.costPriceController.text}');
  print(' ${ItemMasterControllers.departmentController.text}');
  print(' ${ItemMasterControllers.nonStockController.text}');
  // Repeat for all other controllers...

  print(ItemMasterControllers.viewitemnameController.text);
  print(ItemMasterControllers.viewitemdepnameController.text);
}
