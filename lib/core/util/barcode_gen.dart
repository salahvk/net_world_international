import 'dart:ffi';

import 'package:net_world_international/domain/item_get_config/item_get_config/item_get_config.dart';

String genBarcode(ItemGetConfig itemGetConfig) {
  String? barcode1;
  String threeZero = '000';
  int twok = 2000;
  int one = 1;
  int eightZero = 00000000;

  if (itemGetConfig.acCompanyData != null) {
    String? barcodeStartChar = itemGetConfig.acCompanyData?[0].barcodeStartChar;
    print(itemGetConfig.lastbarcode?[0].length);
    if (itemGetConfig.lastbarcode![0].length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);
      print("object");
      int? secondLast = int.parse(last8Digits) + 2001;
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    } else {
      String? secondLast = '00002001';
      const Int64();
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    }
  } else {
    if (itemGetConfig.lastbarcode!.length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);
      int? secondLast = int.parse(last8Digits) + 2001;
      barcode1 = "$one$threeZero$secondLast";
    } else {
      String? secondLast = '00002001';
      barcode1 = "$one$threeZero$secondLast";
    }
  }
  print(barcode1);
  return barcode1;
}

String genBarcode2(ItemGetConfig itemGetConfig) {
  String? barcode1;

  String five = '5';
  String threeZero = '000';
  String twok = '2000';
  String one = '1';
  String eightZero = '00000000';

  if (itemGetConfig.acCompanyData != null) {
    String? barcodeStartChar =
        itemGetConfig.acCompanyData?[0].altBarcodeStartChar;
    if (itemGetConfig.lastbarcode!.length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);
      int? secondLast = int.parse(last8Digits) + 2001;
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    } else {
      String? secondLast = '00002001';
      barcode1 = "$barcodeStartChar$threeZero$secondLast";
    }
  } else {
    if (itemGetConfig.lastbarcode!.length >= 8) {
      String? barcode1last = itemGetConfig.lastbarcode?[0];
      String last8Digits = barcode1last!.substring(barcode1last.length - 8);
      int? secondLast = int.parse(last8Digits) + 2001;
      barcode1 = "$five$threeZero$secondLast";
    } else {
      String? secondLast = '00002001';
      barcode1 = "$five$threeZero$secondLast";
    }
  }
  print(barcode1);
  return barcode1;
}
