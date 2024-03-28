import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../Model/api_response_dto.dart';
import '../Model/purch_line_dto.dart';
import '../service_locator_setup.dart';

class GoodsReceiptLineAdd extends StatefulWidget {
  final GoodsReceiptHeaderDto goodsReceiptHeader;
  const GoodsReceiptLineAdd({super.key, required this.goodsReceiptHeader});

  @override
  State<GoodsReceiptLineAdd> createState() => _GoodsReceiptLineAddState();
}

class _GoodsReceiptLineAddState extends State<GoodsReceiptLineAdd> {
  final _gmkSmsServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _selectedPurchLineDtoList = <int>[];
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;
  var _purchLineDtoList = <PurchLineDto>[];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
    });
    _fetchPurchLineList();
  }

  Future<void> _fetchPurchLineList() async {
    try {
      setState(() => _isLoading = true);
      final response = await _gmkSmsServiceGroupDAL.getPurchLineList(widget.goodsReceiptHeader.purchId);
      // filter the response based on the widget.goodsReceiptHeader.goodsReceiptLines
      if (response.success) {
        _purchLineDtoList = response.data!;
        for (var goodsReceiptLine in widget.goodsReceiptHeader.goodsReceiptLines) {
          _purchLineDtoList.removeWhere((purchLine) => purchLine.lineNumber == goodsReceiptLine.lineNumber);
        }
      }
    }
    on DioException catch (error) {
      ApiResponseDto response = error.response?.data;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goods Receipt Line Add'),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPurchLineList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _selectedPurchLineDtoList.isNotEmpty ? () {
                    _navigator.pop(_selectedPurchLineDtoList.map((index) => _purchLineDtoList[index]).toList());
                  } : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Add Selected Items')
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchLineList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _purchLineDtoList.length,
        itemBuilder: (context, index) {
          return _buildPurchLineListItem(_purchLineDtoList[index], index);
        },
      ),
    );
  }

  Widget _buildPurchLineListItem(PurchLineDto purchLineDto, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: _selectedPurchLineDtoList.contains(index) ? Colors.blue[100] : Colors.white,
        child: ListTile(
          onTap: () {
            setState(() {
              if (_selectedPurchLineDtoList.contains(index)) {
                _selectedPurchLineDtoList.remove(index);
              } else {
                _selectedPurchLineDtoList.add(index);
              }
            });
          },
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Text(
              'Item Id: ${purchLineDto.itemId}, Line Number: ${purchLineDto.lineNumber}',
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
                    purchLineDto.itemName,
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
                    '${purchLineDto.purchQty} ${purchLineDto.purchUnit}',
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
                    '${purchLineDto.remainPurchPhysical} ${purchLineDto.purchUnit}',
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
                    purchLineDto.productType.toString().split('.').last,
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

  TextStyle _purchLineFieldValueStyle() => const TextStyle(fontSize: 16, color: Colors.black);

  TextStyle _purchLineFieldNameStyle() => const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);
}
