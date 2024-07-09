
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_line_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class GoodsReceiptAdd extends StatefulWidget {
  const GoodsReceiptAdd({super.key});

  @override
  State<GoodsReceiptAdd> createState() => _GoodsReceiptAddState();
}

class _GoodsReceiptAddState extends State<GoodsReceiptAdd> {
  final _gmkSmsServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _goodsReceiptHeaderDAL = locator<GoodsReceiptDAL>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;
  var _isLoading = false;
  var _canPop = false;

  // form fields
  // var _purchTableDto = PurchTableDto();
  // var _purchLineDtoList = <PurchLineDto>[];

  // builder
  final _goodsReceiptHeaderDtoBuilder = GoodsReceiptHeaderDtoBuilder();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });

    // Zebra scanner device, only for Android devices
    // It is only activated when adding a new item requisition
    if (Platform.isAndroid)
    {
      Environment.zebraMethodChannel.invokeMethod("registerReceiver");
      Environment.zebraMethodChannel.setMethodCallHandler((call) async {
        if (call.method == "displayScanResult") {
          var scanData = call.arguments["scanData"];
          try {
            var purchOrder = await _gmkSmsServiceGroupDAL.getPurchTable(scanData);
            if (purchOrder.success && purchOrder.data!.purchId.isNotEmpty) {
              setState(() => _goodsReceiptHeaderDtoBuilder.setFromPurchTableDto(purchOrder.data!));
              await _fetchPurchLineList();
            } else {
              _scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(purchOrder.message),
                ),
              );
            }
          } catch (error) {
            _scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(error.toString()),
              ),
            );
          }
        }
        if (call.method == "showToast") {
          _scaffoldMessenger.showSnackBar(SnackBar(
            content: Text(call.arguments as String),
          ));
        }
        return null;
      });
    }
    // end - Zebra scanner device
  }

  @override
  void dispose() {
    Environment.zebraMethodChannel.invokeMethod("unregisterReceiver");
    super.dispose();
  }

  Future<void> saveData() async {
    try {
      setState(() => _isLoading = true);
      if (_goodsReceiptHeaderDtoBuilder.isDefault()) throw ArgumentError('You have not selected any Purchase Order, please select one.');
      if (_goodsReceiptHeaderDtoBuilder.packingSlipId.isEmpty) throw ArgumentError('Product receipt is required.');
      if (_goodsReceiptHeaderDtoBuilder.goodsReceiptLines.isEmpty) throw ArgumentError('No Purchase Line found.');

      _goodsReceiptHeaderDtoBuilder.setIsSubmitted(false);

      final response = await _goodsReceiptHeaderDAL.addAndReturnGoodsReceiptHeaderWithLines(_goodsReceiptHeaderDtoBuilder.build());

      if (response.success) {
        _scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
        _navigator.pushReplacementNamed('/goodsReceiptHeaderDetails', arguments: response.data!);
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
      final response = await _gmkSmsServiceGroupDAL.getPurchLineList(_goodsReceiptHeaderDtoBuilder.purchId);
      _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.clear();
      if (response.success) {
        var purchLineDtoList = response.data!;
        setState(() => _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.addAll(purchLineDtoList.map((e) => GoodsReceiptLineDtoBuilder.fromPurchLineDto(e)).toList()));
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
    return PopScope(
      canPop: _canPop,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmationDialog(
                title: const Text('Confirmation'),
                content: const Text('Are you sure you want to exit without saving?'),
                onConfirm: () {
                  setState(() => _canPop = true);
                  _navigator.pop();
                },
              );
            }
          );
        }
      },
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('New Goods Receipt'),
              actions: [
                IconButton(
                  onPressed: !_goodsReceiptHeaderDtoBuilder.isDefault() ? () {
                    // confirmation dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('Are you sure you want to save this record?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _navigator.pop();
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(Colors.white),
                                backgroundColor: WidgetStateProperty.all(Colors.red),
                              ),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                _navigator.pop();
                                await saveData();
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(Colors.white),
                                backgroundColor: WidgetStateProperty.all(Colors.green),
                              ),
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  } : null,
                  icon: const Icon(Icons.save),
                  tooltip: 'Save',
                ),
              ],
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    text: 'Header',
                  ),
                  Tab(
                    text: 'Lines',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _buildHeaderTab(),
                _buildLineTab(),
              ]
            )
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTab() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 16, top: 16),
              child: Text(
                'New Goods Receipt',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top:8, right: 16, bottom: 3),
              child: Text(
                'Please fill the form below to create new Goods Receipt Header.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.purchId),
              decoration: InputDecoration(
                labelText: 'PO Number',
                suffixIcon: IconButton(
                  onPressed: _purchTableLookup,
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  tooltip: 'Purch Table Lookup',
                ),
              ),
              readOnly: true,
            ),
            TextField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.packingSlipId),
              decoration: const InputDecoration(
                labelText: 'Product receipt',
              ),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setPackingSlipId(value),
            ),
            TextFormField(
              controller: TextEditingController(text: DateFormat("dd/MM/yyyy").format(_goodsReceiptHeaderDtoBuilder.transDate.isAtSameMomentAs(DateTimeHelper.minDateTime) ? DateTime.now() : _goodsReceiptHeaderDtoBuilder.transDate)),
              onTap: _transDatePicker,
              decoration: InputDecoration(
                labelText: 'Receipt Date',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: _transDatePicker,
                )
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{4}-\d{2}-\d{2}')),
              ],
              readOnly: true,
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setTransDate(DateTime.tryParse(value) ?? DateTime.now()),
            ),
            TextField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.description),
              decoration: const InputDecoration(
                labelText: 'Reference GR',
              ),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setDescription(value),
            ),
            TextField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.purchName),
              decoration: const InputDecoration(
                labelText: 'Purch Name',
              ),
              readOnly: true,
            ),
            TextField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.orderAccount),
              decoration: const InputDecoration(
                labelText: 'Order Account',
              ),
              readOnly: true,
            ),
            TextField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.invoiceAccount),
              decoration: const InputDecoration(
                labelText: 'Invoice Account',
              ),
              readOnly: true,
            ),
            TextField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.purchStatus),
              decoration: const InputDecoration(
                labelText: 'Purch Status',
              ),
              readOnly: true,
            ),
          ].map((e) => Padding(padding: const EdgeInsets.only(left: 16, right: 16, bottom: 3), child: e)).toList(),
        ),
      ),
    );
  }

  void _transDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        setState(() => _goodsReceiptHeaderDtoBuilder.setTransDate(value));
      }
    });
  }

  Future<void> _purchTableLookup() async {
    var purchTableDto = await _navigator.pushNamed('/purchTableLookup');
    if (purchTableDto == null) return;

    setState(() => _goodsReceiptHeaderDtoBuilder.setFromPurchTableDto(purchTableDto as PurchTableDto));
    await _fetchPurchLineList();
  }

  Widget _buildLineTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.isNotEmpty ? ListView.builder(
            itemCount: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                      child: Text(
                        'Item Id: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].itemId}, Line Number: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].lineNumber}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        const Divider(color: Colors.grey),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Item Name',
                                style: _purchLineFieldNameStyle(),
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Text(
                                _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].itemName,
                                style: _purchLineFieldValueStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        _sizedBoxLines(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Purch Qty',
                                style: _purchLineFieldNameStyle(),
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Text(
                                '${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty} ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchUnit}',
                                style: _purchLineFieldValueStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        _sizedBoxLines(),
                        // deliver remainder
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Deliver remainder',
                                style: _purchLineFieldNameStyle(),
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Text(
                                '${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].remainPurchPhysical} ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchUnit}',
                                style: _purchLineFieldValueStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        _sizedBoxLines(),
                        // product type
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Product Type',
                                style: _purchLineFieldNameStyle(),
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Text(
                                _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].productType.toString().split('.').last,
                                style: _purchLineFieldValueStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        _sizedBoxLines(),
                      ],
                    ),
                  ),
                ),
              );
            }
          ) : const Center(
            child: Text('No data found\nplease select a Purchase Order.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, height: 1.5)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.isNotEmpty ? _fetchPurchLineList : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Refresh'),
          ),
        ),
      ],
    );
  }

  TextStyle _purchLineFieldValueStyle() => const TextStyle(fontSize: 16, color: Colors.black);

  TextStyle _purchLineFieldNameStyle() => const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);

  SizedBox _sizedBoxLines() => const SizedBox(height: 10);
}
