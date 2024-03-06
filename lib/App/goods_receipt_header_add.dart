import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
import '../Model/goods_receipt_header_dto.dart';
import '../Model/purch_table_dto.dart';
import '../service_locator_setup.dart';

class GoodsReceiptHeaderAdd extends StatefulWidget {
  const GoodsReceiptHeaderAdd({super.key});

  @override
  State<GoodsReceiptHeaderAdd> createState() => _GoodsReceiptHeaderAddState();
}

class _GoodsReceiptHeaderAddState extends State<GoodsReceiptHeaderAdd> {
  final gmkSmsServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final goodsReceiptHeaderDAL = locator<GoodsReceiptHeaderDAL>();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;

  // form fields
  var _purchTableDto = PurchTableDto();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });
  }

  Future<void> saveData() async {
    try {
      if (_purchTableDto.isDefault()) throw ArgumentError('You have not selected any Purchase Order, please select one.');

      final goodsReceiptHeaderDto = GoodsReceiptHeaderDto(
        purchId: _purchTableDto.purchId,
        purchName: _purchTableDto.purchName,
        orderAccount: _purchTableDto.orderAccount,
        invoiceAccount: _purchTableDto.invoiceAccount,
        purchStatus: _purchTableDto.purchStatus
      );
      await goodsReceiptHeaderDAL.addGoodsReceiptHeader(goodsReceiptHeaderDto);
      _navigator.pop();
    }
    on DioException catch (error) {
      ApiResponseDto<GoodsReceiptHeaderDto> response = error.response?.data;
      _scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(response.message)
        ),
      );
    }
    catch (error) {
      _scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(error.toString())
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goods Receipt Header Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      _navigator.pushNamed('/purchTableLookup').then((value) {
                        var purchTableDto = value as PurchTableDto;
                        setState(() {
                          _purchTableDto = purchTableDto;
                        });
                      });
                    },
                    child: const Text('Purch Table Lookup'),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          title: const Text('Purch Id'),
                          subtitle: _purchTableDto.purchId.isEmpty ? const Text('<blank>') : Text(_purchTableDto.purchId),
                          dense: true,
                        ),
                        ListTile(
                          title: const Text('Purch Name'),
                          subtitle: _purchTableDto.purchName.isEmpty ? const Text('<blank>') : Text(_purchTableDto.purchName),
                          dense: true,
                        ),
                        ListTile(
                          title: const Text('Order Account'),
                          subtitle: _purchTableDto.orderAccount.isEmpty ? const Text('<blank>') : Text(_purchTableDto.orderAccount),
                          dense: true,
                        ),
                        ListTile(
                          title: const Text('Invoice Account'),
                          subtitle: _purchTableDto.invoiceAccount.isEmpty ? const Text('<blank>') : Text(_purchTableDto.invoiceAccount),
                          dense: true,
                        ),
                        ListTile(
                          title: const Text('Purch Status'),
                          subtitle: _purchTableDto.purchStatus.isEmpty ? const Text('<blank>') : Text(_purchTableDto.purchStatus),
                          dense: true,
                        ),
                      ],
                    ),
                  ),
                ]
              ),
            ),
            ElevatedButton(
              // style from height
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)
              ),
              onPressed: () {
                saveData();
              },
              child: const Text('Create Goods Receipt Header'),
            ),
          ],
        ),
      )
    );
  }
}
