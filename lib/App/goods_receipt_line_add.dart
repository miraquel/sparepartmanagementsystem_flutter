import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_line_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../DataAccessLayer/Abstract/goods_receipt_line_dal.dart';
import '../Model/purch_line_dto.dart';
import '../service_locator_setup.dart';

class GoodsReceiptLineAdd extends StatefulWidget {
  final GoodsReceiptHeaderDto goodsReceiptHeader;
  const GoodsReceiptLineAdd({super.key, required this.goodsReceiptHeader});

  @override
  State<GoodsReceiptLineAdd> createState() => _GoodsReceiptLineAddState();
}

class _GoodsReceiptLineAddState extends State<GoodsReceiptLineAdd> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  // final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  // final _goodsReceiptLineDAL = locator<GoodsReceiptLineDAL>();
  // late ScaffoldMessengerState _scaffoldMessengerState;
  // var _purchLineDtoList = <PurchLineDto>[];
  // var _goodsReceiptLineDto = GoodsReceiptLineDto();
  //
  // final _purchQtyTextController = TextEditingController();
  // final _wMSLocationIdTextController = TextEditingController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _scaffoldMessengerState = ScaffoldMessenger.of(context);
  //     _fetchData();
  //   });
  // }
  //
  // Future<void> _fetchData() async {
  //   try {
  //     final purchLineResponse = await _gmkSMSServiceGroupDAL.getPurchLineList(widget.goodsReceiptHeader.purchId);
  //     if (purchLineResponse.success) {
  //       _purchLineDtoList = purchLineResponse.data!;
  //     }
  //     final goodsReceiptLineResponse = await _goodsReceiptLineDAL.getGoodsReceiptLineByParams(
  //       GoodsReceiptLineDto(
  //         goodsReceiptHeaderId: widget.goodsReceiptHeader.goodsReceiptHeaderId,
  //
  //       ),
  //     );
  //     if (goodsReceiptLineResponse.success) {
  //       _goodsReceiptLineDto = goodsReceiptLineResponse.data!;
  //     }
  //   } catch (error) {
  //     _scaffoldMessengerState.showSnackBar(SnackBar(
  //       content: Text('Error fetching purchase lines: $error')
  //     ));
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Add Goods Receipt Line'),
  //     ),
  //     body: Column(
  //       children: [
  //         DropdownSearch(
  //           items: _purchLineDtoList,
  //           itemAsString: (PurchLineDto item) => item.itemId,
  //           selectedItem: _purchLineDtoList[0],
  //         ),
  //         SingleChildScrollView(
  //           child: Form(
  //             child: Column(
  //               children: [
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'Item Id'),
  //                   initialValue: _purchLineDtoList[0].itemId,
  //                   enabled: false,
  //                 ),
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'Item Name'),
  //                   initialValue: _purchLineDtoList[0].itemName,
  //                   enabled: false,
  //                 ),
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'Line Number'),
  //                   initialValue: _purchLineDtoList[0].lineNumber.toString(),
  //                   enabled: false,
  //                 ),
  //                 TextFormField(
  //                   controller: _purchQtyTextController,
  //                   decoration: const InputDecoration(labelText: 'Quantity'),
  //                   keyboardType: TextInputType.number,
  //                   initialValue: _purchLineDtoList[0].purchQty.toString(),
  //                 ),
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'Unit'),
  //                   initialValue: _purchLineDtoList[0].purchUnit,
  //                   enabled: false,
  //                 ),
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'Price'),
  //                   keyboardType: TextInputType.number,
  //                   initialValue: _purchLineDtoList[0].purchPrice.toString(),
  //                   enabled: false,
  //                 ),
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'Warehouse'),
  //                   initialValue: _goodsReceiptLineDto.inventLocationId,
  //                   enabled: false,
  //                 ),
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'WMS Location Id'),
  //                   initialValue: _goodsReceiptLineDto.wMSLocationId,
  //                   enabled: false,
  //                 ),
  //                 TextFormField(
  //                   decoration: const InputDecoration(labelText: 'Line Amount'),
  //                   keyboardType: TextInputType.number,
  //                   initialValue: _purchLineDtoList[0].lineAmount.toString(),
  //                   enabled: false,
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () async {
  //                     // save data
  //                   },
  //                   child: const Text('Save'),
  //                 )
  //               ],
  //             ),
  //           )
  //         )
  //       ],
  //     )
  //   );
  // }
}
