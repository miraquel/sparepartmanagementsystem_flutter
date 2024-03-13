import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
import '../DataAccessLayer/Abstract/goods_receipt_line_dal.dart';
import '../Model/goods_receipt_header_dto.dart';
import '../Model/goods_receipt_line_dto.dart';
import '../Model/purch_table_dto.dart';
import '../service_locator_setup.dart';

class GoodsReceiptAdd extends StatefulWidget {
  const GoodsReceiptAdd({super.key});

  @override
  State<GoodsReceiptAdd> createState() => _GoodsReceiptAddState();
}

class _GoodsReceiptAddState extends State<GoodsReceiptAdd> {
  final gmkSmsServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final goodsReceiptHeaderDAL = locator<GoodsReceiptHeaderDAL>();
  final goodsReceiptLineDAL = locator<GoodsReceiptLineDAL>();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;
  var _isLoading = false;

  // form fields
  var _purchTableDto = PurchTableDto();
  var _purchLineDtoList = <PurchLineDto>[];

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
      setState(() => _isLoading = true);
      if (_purchTableDto.isDefault()) throw ArgumentError('You have not selected any Purchase Order, please select one.');

      final goodsReceiptHeaderDto = GoodsReceiptHeaderDto(
        purchId: _purchTableDto.purchId,
        purchName: _purchTableDto.purchName,
        orderAccount: _purchTableDto.orderAccount,
        invoiceAccount: _purchTableDto.invoiceAccount,
        purchStatus: _purchTableDto.purchStatus,
        isSubmitted: false,
      );

      final goodsReceiptLineDtoList = _purchLineDtoList.map((e) => GoodsReceiptLineDto(
        itemId: e.itemId,
        lineNumber: e.lineNumber,
        itemName: e.itemName,
        purchUnit: e.purchUnit,
        purchQty: e.purchQty,
        lineAmount: e.lineAmount,
        purchPrice: e.purchPrice,
      )).toList();

      goodsReceiptHeaderDto.goodsReceiptLines.addAll(goodsReceiptLineDtoList);

      final response = await goodsReceiptHeaderDAL.addGoodsReceiptHeaderWithLines(goodsReceiptHeaderDto);

      if (response.success) {
        _navigator.pop();
      } else {
        throw Exception(response.message);
      }
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
    finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchPurchLineList() async {
    try {
      setState(() => _isLoading = true);
      final response = await gmkSmsServiceGroupDAL.getPurchLineList(_purchTableDto.purchId);
      if (response.success) {
        _purchLineDtoList = response.data!;
      }
    }
    on DioException catch (error) {
      ApiResponseDto<List<PurchTableDto>> response = error.response?.data;
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
    finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Goods Receipt Header Add'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
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
                        _fetchPurchLineList();
                      });
                    },
                    child: const Text('Purch Table Lookup'),
                  ),
                  Accordion(
                    headerPadding: const EdgeInsets.all(20),
                    headerBorderRadius: 0,
                    contentBorderRadius: 0,
                    scaleWhenAnimating: false,
                    maxOpenSections: 1,
                    disableScrolling: true,
                    children: [
                      AccordionSection(
                        isOpen: !_purchTableDto.isDefault() ? true : false,
                        header: const Text("Header", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                        )),
                        content: ListView(
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
                      AccordionSection(
                          header: const Text("Lines", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          )),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  border: TableBorder.all(),
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Center(child: Text('Item Id', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Name', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                                    ),
                                    // Purch Unit
                                    DataColumn(
                                      label: Center(child: Text('Unit', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Qty', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                                    ),
                                  ],
                                  rows: _purchLineDtoList.map((PurchLineDto purchLineDto) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(purchLineDto.itemId)),
                                      DataCell(Text(purchLineDto.itemName)),
                                      DataCell(Text(purchLineDto.purchUnit)),
                                      DataCell(Text(purchLineDto.purchQty.toString())),
                                    ],
                                  )).toList(),
                                ),
                              ),
                            ],
                          )
                      )
                    ]
                  ),
                ]
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
      ),
    );
  }
}
