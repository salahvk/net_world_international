import 'package:intl/intl.dart';
import 'package:net_world_international/core/controllers/controllers.dart';

void getCurrentDateTimeAndStore() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now);

  ItemMasterControllers.createddateController.text = formattedDate;
  ItemMasterControllers.moddateController.text = formattedDate;
}
