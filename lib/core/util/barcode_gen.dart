import 'package:net_world_international/domain/core/api_endpoint.dart';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

Future<String> genBarcode(ItemGetConfig itemGetConfig) async {
  String? barcode1;
  // String threeZero = '000';
  // int one = 1;

  // if (itemGetConfig.acCompanyData != null) {
  //   String? barcodeStartChar = itemGetConfig.acCompanyData?[0].barcodeStartChar;

  //   if (itemGetConfig.lastbarcode![0].length >= 8) {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String last8Digits = barcode1last!.substring(barcode1last.length - 8);

  //     int? secondLast = int.parse(last8Digits) + 20001;
  //     barcode1 = "$barcodeStartChar$threeZero$secondLast";
  //   } else {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String remainingDigits = barcode1last!.padRight(8, '0');
  //     int secondLast = int.parse(remainingDigits) + 20001;
  //     barcode1 = "$barcodeStartChar$threeZero$secondLast";
  //   }
  // } else {
  //   if (itemGetConfig.lastbarcode![0].length >= 8) {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String last8Digits = barcode1last!.substring(barcode1last.length - 8);
  //     int? secondLast = int.parse(last8Digits) + 20001;
  //     barcode1 = "$one$threeZero$secondLast";
  //   } else {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String remainingDigits = barcode1last!.padRight(8, '0');
  //     int secondLast = int.parse(remainingDigits) + 20001;
  //     barcode1 = "$one$threeZero$secondLast";
  //   }
  // }
  // log(barcode1);
  final endPoint = Hive.box("url").get('endpoint');
  final apiUrl = "$endPoint${ApiEndPoint.genBarcode}";
  final url = Uri.parse(apiUrl);
  final headers = {'Content-Type': 'application/json'};
  final response = await http.get(
    url,
    headers: headers,
  );
  // log(response.body);

  // if (response.statusCode == 200 || response.statusCode == 201) {
  //   final result = ItemGetConfig.fromJson(jsonResponse);

  //   GlobalList().taxList.addAll(result.taxList ?? []);
  //   return Right(result);
  // } else {
  //   return const Left(MainFailure.serverFailure());
  // }
  return response.body;
}

Future<String> genBarcode2(ItemGetConfig itemGetConfig) async {
  // String? barcode1;

  // String five = '5';
  // String threeZero = '000';

  // if (itemGetConfig.acCompanyData != null) {
  //   String? barcodeStartChar =
  //       itemGetConfig.acCompanyData?[0].altBarcodeStartChar;
  //   if (itemGetConfig.lastbarcode![0].length >= 8) {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String last8Digits = barcode1last!.substring(barcode1last.length - 8);
  //     int? secondLast = int.parse(last8Digits) + 20001;
  //     barcode1 = "$barcodeStartChar$threeZero$secondLast";
  //   } else {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String remainingDigits = barcode1last!.padRight(8, '0');
  //     int secondLast = int.parse(remainingDigits) + 20001;
  //     barcode1 = "$barcodeStartChar$threeZero$secondLast";
  //   }
  // } else {
  //   if (itemGetConfig.lastbarcode![0].length >= 8) {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String last8Digits = barcode1last!.substring(barcode1last.length - 8);
  //     int? secondLast = int.parse(last8Digits) + 20001;
  //     barcode1 = "$five$threeZero$secondLast";
  //   } else {
  //     String? barcode1last = itemGetConfig.lastbarcode?[0];
  //     String remainingDigits = barcode1last!.padRight(8, '0');
  //     int secondLast = int.parse(remainingDigits) + 20001;
  //     barcode1 = "$five$threeZero$secondLast";
  //   }
  // }
  final endPoint = Hive.box("url").get('endpoint');
  final apiUrl = "$endPoint${ApiEndPoint.genAlternateBarcode}";
  final url = Uri.parse(apiUrl);
  final headers = {'Content-Type': 'application/json'};
  final response = await http.get(
    url,
    headers: headers,
  );
  return response.body;
}
