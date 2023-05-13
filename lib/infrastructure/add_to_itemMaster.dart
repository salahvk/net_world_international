import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/domain/core/api_endPoint.dart';

nextBarCode(barcode) async {
  if (ItemMasterControllers.barCodeController.text.isEmpty) {
    barcode = ItemMasterControllers.barCodeController.text;
  }

  // if (response.statusCode == 200 || response.statusCode == 201) {
  // final result = LoginModel.fromJson(jsonResponse);
  // log(response.body);
  try {
    final url = Uri.parse(ApiEndPoint.getNextItem);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"barcode": barcode, "selectrow": "next"});

    final response = await http.post(url, headers: headers, body: body);

    //  log(response.data.toString());
    var jsonResponse = jsonDecode(response.body);
    ItemMasterControllers.barCodeController.text = jsonResponse["barcode"];
    print(jsonResponse["barcode"]);
  } catch (_) {}

  // } else {
  //   // return const Left(MainFailure.serverFailure());
  // }
}

prevBarCode(barcode) async {
  if (ItemMasterControllers.barCodeController.text.isEmpty) {
    barcode = ItemMasterControllers.barCodeController.text;
  }

  try {
    final url = Uri.parse(ApiEndPoint.getNextItem);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"barcode": barcode, "selectrow": "previous"});

    final response = await http.post(url, headers: headers, body: body);

    //  log(response.data.toString());
    var jsonResponse = jsonDecode(response.body);
    // if (response.statusCode == 200 || response.statusCode == 201) {
    // final result = LoginModel.fromJson(jsonResponse);
    // log(response.body);
    ItemMasterControllers.barCodeController.text = jsonResponse["barcode"];
    print(jsonResponse["barcode"]);
  } catch (_) {}

  // } else {
  //   // return const Left(MainFailure.serverFailure());
  // }
}
