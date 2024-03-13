import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/currency_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/numerical_range_formatter.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
import '../Model/goods_receipt_header_dto.dart';
import '../Model/goods_receipt_header_dto_builder.dart';
import '../Model/wms_location_dto.dart';
import '../service_locator_setup.dart';

class GoodsReceiptDetails extends StatefulWidget {
  final int goodsReceiptHeaderId;
  const GoodsReceiptDetails({super.key, required this.goodsReceiptHeaderId});

  @override
  State<GoodsReceiptDetails> createState() => _GoodsReceiptDetailsState();
}

class _GoodsReceiptDetailsState extends State<GoodsReceiptDetails> {
  final _goodsReceiptHeaderDAL = locator<GoodsReceiptHeaderDAL>();
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  late ScaffoldMessengerState _scaffoldMessengerState;
  late NavigatorState _navigator;
  var _isLoading = false;

  var _goodsReceiptHeader = GoodsReceiptHeaderDto();
  var _purchLineDtoList = <PurchLineDto>[];
  var _goodsReceiptHeaderDtoBuilder = GoodsReceiptHeaderDtoBuilder();
  //var _goodsReceiptLineDtoBuilder = <GoodsReceiptLineDtoBuilder>[];
  final _controllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessengerState = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    try {
      setState(() => _isLoading = true);
      final goodsReceiptHeaderResponse = await _goodsReceiptHeaderDAL.getGoodsReceiptHeaderByIdWithLines(widget.goodsReceiptHeaderId);
      if (goodsReceiptHeaderResponse.success) {
        _goodsReceiptHeader = goodsReceiptHeaderResponse.data!;
        _goodsReceiptHeaderDtoBuilder = GoodsReceiptHeaderDtoBuilder.fromDto(goodsReceiptHeaderResponse.data!);
        //_goodsReceiptLineDtoBuilder = _goodsReceiptHeader.goodsReceiptLines.map((goodsReceiptLine) => GoodsReceiptLineDtoBuilder.fromDto(goodsReceiptLine)).toList();
      }
      final purchLineResponse = await _gmkSMSServiceGroupDAL.getPurchLineList(_goodsReceiptHeader.purchId);
      if (purchLineResponse.success) {
        _purchLineDtoList = purchLineResponse.data!;
      }
    } catch (error) {
      _scaffoldMessengerState.showSnackBar(SnackBar(
        content: Text('Error fetching goods receipt header details: $error')
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _postData() async {
    try {
      setState(() => _isLoading = true);
      final goodsReceiptHeaderResponse = await _goodsReceiptHeaderDAL.postToAX(_goodsReceiptHeaderDtoBuilder.build());
      if (goodsReceiptHeaderResponse.success) {
        _scaffoldMessengerState.showSnackBar(const SnackBar(
          content: Text('Goods receipt header posted to AX')
        ));
      }
    } catch (error) {
      _scaffoldMessengerState.showSnackBar(SnackBar(
        content: Text('Error posting goods receipt header to AX: $error')
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // create 2 tabs, one for the header and one for the lines
    return LoadingOverlay(
      isLoading: _isLoading,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Goods Receipt Details'),
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
              // Header tab
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.packingSlipId),
                        onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setPackingSlipId(value),
                        decoration: const InputDecoration(
                          labelText: 'Packing Slip Id',
                        ),

                      ),
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
                            isOpen: !_goodsReceiptHeader.isDefault() ? true : false,
                            header: const Text("Header", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15
                            )),
                            content: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Purch Id'),
                                  subtitle: _goodsReceiptHeader.purchId.isEmpty ? const Text('<blank>') : Text(_goodsReceiptHeader.purchId),
                                  dense: true,
                                ),
                                ListTile(
                                  title: const Text('Purch Name'),
                                  subtitle: _goodsReceiptHeader.purchName.isEmpty ? const Text('<blank>') : Text(_goodsReceiptHeader.purchName),
                                  dense: true,
                                ),
                                ListTile(
                                  title: const Text('Order Account'),
                                  subtitle: _goodsReceiptHeader.orderAccount.isEmpty ? const Text('<blank>') : Text(_goodsReceiptHeader.orderAccount),
                                  dense: true,
                                ),
                                ListTile(
                                  title: const Text('Invoice Account'),
                                  subtitle: _goodsReceiptHeader.invoiceAccount.isEmpty ? const Text('<blank>') : Text(_goodsReceiptHeader.invoiceAccount),
                                  dense: true,
                                ),
                                ListTile(
                                  title: const Text('Purch Status'),
                                  subtitle: _goodsReceiptHeader.purchStatus.isEmpty ? const Text('<blank>') : Text(_goodsReceiptHeader.purchStatus),
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
                  ],
                ),
              ),
              // Lines tab
              // create a table to display the lines with add, edit, and delete capability
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _navigator.pushNamed('/goodsReceiptLineAdd', arguments: _goodsReceiptHeader);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)
                      ),
                      child: const Text('Add Line'),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) { return const Divider(
                        thickness: 1,
                        color: Colors.black,
                      );},
                      itemCount: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.length,
                      itemBuilder: (context, index) {
                        _controllers.add(TextEditingController(text: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty.toInt().toString()));
                        return ListTile(
                          title: Text(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].itemId),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].itemName}"),
                              const SizedBox(height: 10),
                              Text("Qty: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty} / ${_goodsReceiptHeader.goodsReceiptLines[index].purchQty}"),
                              Text("Unit: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchUnit}"),
                              Text("Price: ${numberToIdr(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchPrice, 2)}"),
                              Text("Amount: ${numberToIdr(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty * _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchPrice, 2)}"),
                              const SizedBox(height: 10),
                              // create a button
                              Text("Warehouse: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].inventLocationId}"),
                              Text("Location: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].wMSLocationId}"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  _navigator.pushNamed('/wMSLocationLookup').then((value) {
                                    if (value != null) {
                                      setState(() {
                                        var wMSLocationDto = value as WMSLocationDto;
                                        _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setInventLocationId(wMSLocationDto.inventLocationId);
                                        _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setWMSLocationId(wMSLocationDto.wMSLocationId);
                                      });
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(40)
                                ),
                                child: const Text('Edit Location'),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // minus icon
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty > 1) {
                                      _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setPurchQty(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty - 1);
                                      _controllers[index].text = _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty.toInt().toString();
                                    }
                                  });
                                },
                              ),
                              // quantity text field
                              SizedBox(
                                width: 60,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Qty',
                                    floatingLabelAlignment: FloatingLabelAlignment.center,
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: _controllers[index],
                                  onChanged: (value) {
                                    setState(() {
                                      var valueParsed = int.tryParse(value) ?? 1;
                                      if (valueParsed <= _goodsReceiptHeader.goodsReceiptLines[index].purchQty && valueParsed >= 1) {
                                        _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setPurchQty(valueParsed.toDouble());
                                      }
                                      if (valueParsed == 1) {
                                        _controllers[index].text = valueParsed.toString();
                                      }
                                    });
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    NumericalRangeFormatter(min: 1, max: _goodsReceiptHeader.goodsReceiptLines[index].purchQty)
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              // plus icon
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    if (_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty < _goodsReceiptHeader.goodsReceiptLines[index].purchQty) {
                                      _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setPurchQty(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty + 1);
                                      _controllers[index].text = _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty.toInt().toString();
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_goodsReceiptHeaderDtoBuilder.isSubmitted == false) {
                          _postData();
                          _navigator.pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)
                      ),
                      child: const Text('Post to AX'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
