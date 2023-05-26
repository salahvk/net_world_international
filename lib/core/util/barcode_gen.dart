import 'dart:developer';
import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';

String genBarcode(ItemGetConfig itemGetConfig) {
  String? barcode1;
  String threeZero = '000';
  int one = 1;

  if (itemGetConfig.acCompanyData != null) {
    String? barcodeStartChar = itemGetConfig.acCompanyData?[0].barcodeStartChar;

    if (itemGetConfig.lastbarcode![0].length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);

      int? secondLast = int.parse(last8Digits) + 20001;
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    } else {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String remainingDigits = barcode1last!.padRight(8, '0');
      int secondLast = int.parse(remainingDigits) + 20001;
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    }
  } else {
    if (itemGetConfig.lastbarcode![0].length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);
      int? secondLast = int.parse(last8Digits) + 20001;
      barcode1 = "$one$threeZero$secondLast";
    } else {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String remainingDigits = barcode1last!.padRight(8, '0');
      int secondLast = int.parse(remainingDigits) + 20001;
      barcode1 = "$one$threeZero$secondLast";
    }
  }
  log(barcode1);
  return barcode1;
}

String genBarcode2(ItemGetConfig itemGetConfig) {
  String? barcode1;

  String five = '5';
  String threeZero = '000';

  if (itemGetConfig.acCompanyData != null) {
    String? barcodeStartChar =
        itemGetConfig.acCompanyData?[0].altBarcodeStartChar;
    if (itemGetConfig.lastbarcode![0].length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);
      int? secondLast = int.parse(last8Digits) + 20001;
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    } else {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String remainingDigits = barcode1last!.padRight(8, '0');
      int secondLast = int.parse(remainingDigits) + 20001;
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    }
  } else {
    if (itemGetConfig.lastbarcode![0].length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);
      int? secondLast = int.parse(last8Digits) + 20001;
      barcode1 = "$five$threeZero$secondLast";
    } else {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String remainingDigits = barcode1last!.padRight(8, '0');
      int secondLast = int.parse(remainingDigits) + 20001;
      barcode1 = "$five$threeZero$secondLast";
    }
  }
  return barcode1;
}
