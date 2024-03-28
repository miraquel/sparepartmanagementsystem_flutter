
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
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
  final _gmkSmsServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _goodsReceiptHeaderDAL = locator<GoodsReceiptHeaderDAL>();
  final packingSlipIdController = TextEditingController();
  final transDateController = TextEditingController();
  final descriptionController = TextEditingController();
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
      if (packingSlipIdController.text.isEmpty) throw ArgumentError('Packing Slip Id is required.');
      if (_purchLineDtoList.isEmpty) throw ArgumentError('No Purchase Line found.');

      final goodsReceiptHeaderDto = GoodsReceiptHeaderDto(
        purchId: _purchTableDto.purchId,
        purchName: _purchTableDto.purchName,
        orderAccount: _purchTableDto.orderAccount,
        invoiceAccount: _purchTableDto.invoiceAccount,
        purchStatus: _purchTableDto.purchStatus,
        isSubmitted: false,
        packingSlipId: packingSlipIdController.text,
        transDate: DateTime.tryParse(transDateController.text) ?? DateTime.now(),
        description: descriptionController.text,
      );

      final goodsReceiptLineDtoList = _purchLineDtoList.map((e) => GoodsReceiptLineDto(
        itemId: e.itemId,
        lineNumber: e.lineNumber,
        itemName: e.itemName,
        productType: e.productType,
        purchUnit: e.purchUnit,
        remainPurchPhysical: e.remainPurchPhysical,
        receiveNow: e.remainPurchPhysical,
        purchQty: e.purchQty,
        lineAmount: e.lineAmount,
        purchPrice: e.purchPrice,
      )).toList();

      goodsReceiptHeaderDto.goodsReceiptLines.addAll(goodsReceiptLineDtoList);

      final response = await _goodsReceiptHeaderDAL.addGoodsReceiptHeaderWithLines(goodsReceiptHeaderDto);

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
      final response = await _gmkSmsServiceGroupDAL.getPurchLineList(_purchTableDto.purchId);
      if (response.success) {
        _purchLineDtoList = response.data!;
        transDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('New Goods Receipt'),
            actions: [
              IconButton(
                onPressed: !_purchTableDto.isDefault() ? () {
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
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                            ),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              _navigator.pop();
                              await saveData();
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(Colors.green),
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
    );
  }

  Widget _buildHeaderTab() {
    return SingleChildScrollView(
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
            controller: TextEditingController(text: _purchTableDto.purchId),
            onTap: _purchTableLookup,
            decoration: InputDecoration(
              labelText: 'Purch Id',
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
            controller: packingSlipIdController,
            decoration: const InputDecoration(
              labelText: 'Packing Slip Id',
            ),
          ),
          TextFormField(
            controller: transDateController,
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
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          TextField(
            controller: TextEditingController(text: _purchTableDto.purchName),
            decoration: const InputDecoration(
              labelText: 'Purch Name',
            ),
            readOnly: true,
          ),
          TextField(
            controller: TextEditingController(text: _purchTableDto.orderAccount),
            decoration: const InputDecoration(
              labelText: 'Order Account',
            ),
            readOnly: true,
          ),
          TextField(
            controller: TextEditingController(text: _purchTableDto.invoiceAccount),
            decoration: const InputDecoration(
              labelText: 'Invoice Account',
            ),
            readOnly: true,
          ),
          TextField(
            controller: TextEditingController(text: _purchTableDto.purchStatus),
            decoration: const InputDecoration(
              labelText: 'Purch Status',
            ),
            readOnly: true,
          ),
        ].map((e) => Padding(padding: const EdgeInsets.only(left: 16, right: 16, bottom: 3), child: e)).toList(),
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
        setState(() {
          transDateController.text = DateFormat("dd/MM/yyyy").format(value);
        });
      }
    });
  }

  void _purchTableLookup() {
    _navigator.pushNamed('/purchTableLookup').then((value) {
      var purchTableDto = value as PurchTableDto;
      setState(() {
        _purchTableDto = purchTableDto;
      });
      _fetchPurchLineList();
    });
  }

  Widget _buildLineTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _purchLineDtoList.isNotEmpty ? ListView.builder(
            itemCount: _purchLineDtoList.length,
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
                        'Item Id: ${_purchLineDtoList[index].itemId}, Line Number: ${_purchLineDtoList[index].lineNumber}',
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
                            Text(
                              _purchLineDtoList[index].itemName,
                              style: _purchLineFieldValueStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
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
                            Text(
                              '${_purchLineDtoList[index].purchQty} ${_purchLineDtoList[index].purchUnit}',
                              style: _purchLineFieldValueStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
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
                            Text(
                              '${_purchLineDtoList[index].remainPurchPhysical} ${_purchLineDtoList[index].purchUnit}',
                              style: _purchLineFieldValueStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
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
                            Text(
                              _purchLineDtoList[index].productType.toString().split('.').last,
                              style: _purchLineFieldValueStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
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
            onPressed: _purchLineDtoList.isNotEmpty ? _fetchPurchLineList : null,
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
}
