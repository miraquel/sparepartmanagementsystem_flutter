import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/Model/vend_packing_slip_jour_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/vend_packing_slip_trans_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class PrinterHelper {
  static final Logger _logger = locator<Logger>();

  static Future<void> printLabel(BluetoothDevice bluetoothDevice, List<String> data) async {
    await bluetoothDevice.connect();
    var services = await bluetoothDevice.discoverServices();
    var printerWriter = services[2].characteristics[1];
    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      await printerWriter.write(generator.rawBytes(data.join("\r\n").codeUnits));
    } catch (e) {
      _logger.e(e);
    }
  }

  static List<String> vendPackingSlipTemplate(VendPackingSlipJourDto vendPackingSlipJour, VendPackingSlipTransDto vendPackingSlipTrans, int copies) {
    var itemName = <String>[];

    if (vendPackingSlipTrans.itemName.length > 44) {
      var firstLine = vendPackingSlipTrans.itemName.substring(0, 44).trim();
      itemName.add('TEXT 0, 5, "1", 0, 1, 2, "$firstLine"');

      var secondLine = vendPackingSlipTrans.itemName.substring(firstLine.length).trim();
      itemName.add('TEXT 0, 55, "0", 0, 1, 2, "${secondLine.length > 44 ? PrinterHelper._truncateWithEllipsis(secondLine, 44) : secondLine}"');
    } else {
      var firstLine = vendPackingSlipTrans.itemName.trim();
      // replace \" with \["]
      firstLine = firstLine.replaceAll("\"", "\\[\"]");
      itemName.add("TEXT 0, 25, \"1\", 0, 1, 2, \"$firstLine\"");
    }

    var printData = [
      'SIZE 72 mm,30 mm',
      'CLS',
      'CODEPAGE 850',
      ...itemName,
      'TEXT 0, 110, "1", 0, 1, 1, "Item Id: ${vendPackingSlipTrans.itemId}"',
      'TEXT 0, 150, "1", 0, 1, 1, "GR No: ${vendPackingSlipJour.internalPackingSlipId}"',
      'TEXT 0, 190, "1", 0, 1, 1, "GR Date: ${DateFormat('dd-MMM-yyyy').format(vendPackingSlipJour.deliveryDate)}"',
      'QRCODE 320,110,H,3,A,0,"http://www.gmk.id/${vendPackingSlipTrans.itemId}/"',
      'PRINT 1,$copies',
      'END',
    ];
    return printData;
  }

  static String _truncateWithEllipsis(String str, int cutoff) {
    return (str.length <= cutoff) ? str : '${str.substring(0, cutoff)}...';
  }

  static String getItemIdFromUrl(String url) {
    var uri = Uri.dataFromString(url);
    var itemId = uri.pathSegments[3];
    return itemId;
  }
}