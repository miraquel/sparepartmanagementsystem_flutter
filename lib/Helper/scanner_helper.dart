import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> scanQR() async {
  String barcodeScanRes;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }

  return barcodeScanRes;
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<String> scanBarcodeNormal() async {
  String barcodeScanRes;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }

  return barcodeScanRes;
}