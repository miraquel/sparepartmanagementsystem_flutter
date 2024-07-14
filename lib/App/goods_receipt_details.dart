import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/printer_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/vend_packing_slip_jour_dto.dart';
import 'package:unicons/unicons.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/numerical_min_formatter.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_line_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/product_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class GoodsReceiptDetails extends StatefulWidget {
  final int? goodsReceiptHeaderId;
  final GoodsReceiptHeaderDto? goodsReceiptHeaderDto;
  const GoodsReceiptDetails({super.key, this.goodsReceiptHeaderId, this.goodsReceiptHeaderDto});

  @override
  State<GoodsReceiptDetails> createState() => _GoodsReceiptDetailsState();
}

class _GoodsReceiptDetailsState extends State<GoodsReceiptDetails> with TickerProviderStateMixin {
  final _goodsReceiptHeaderDAL = locator<GoodsReceiptDAL>();
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;
  var _isLoading = false;
  var _isEditing = false;
  var _canPop = false;
  late TabController _tabController;
  int tabIndex = 0;
  GoodsReceiptLineDtoBuilder? _goodsReceiptLineDtoBuilderScan;

  var _goodsReceiptHeader = GoodsReceiptHeaderDto();
  var _goodsReceiptHeaderDtoBuilder = GoodsReceiptHeaderDtoBuilder();
  var _vendPackingSlipJour = VendPackingSlipJourDto();
  final _controllers = <TextEditingController>[];

  bool get _isModified => _goodsReceiptHeaderDtoBuilder.build().compare(_goodsReceiptHeader);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
    });
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.animation?.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
    });

    if (widget.goodsReceiptHeaderDto != null) {
      setState(() {
        _goodsReceiptHeader = widget.goodsReceiptHeaderDto!;
        _goodsReceiptHeaderDtoBuilder = GoodsReceiptHeaderDtoBuilder.fromDto(widget.goodsReceiptHeaderDto!);
      });
    }
    else {
      _fetchData();
    }

    // Zebra scanner device, only for Android devices
    // It is only activated when adding a new item requisition
    if (Platform.isAndroid)
    {
      Environment.zebraMethodChannel.invokeMethod("registerReceiver");
      Environment.zebraMethodChannel.setMethodCallHandler((call) async {
        if (call.method == "displayScanResult") {
          if (_goodsReceiptLineDtoBuilderScan == null) {
            _scaffoldMessenger.showSnackBar(const SnackBar(
              content: Text('Please scan the location by selecting the button scan on each line'),
            ));
            return null;
          }
          var scanData = call.arguments["scanData"];
          await _getWMSLocation(scanData, _goodsReceiptLineDtoBuilderScan!);
          _goodsReceiptLineDtoBuilderScan = null;
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
    _tabController.dispose();
    Environment.zebraMethodChannel.invokeMethod("unregisterReceiver");
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      setState(() => _isLoading = true);
      final goodsReceiptHeaderResponse = await _goodsReceiptHeaderDAL.getGoodsReceiptHeaderByIdWithLines(widget.goodsReceiptHeaderId!);
      if (goodsReceiptHeaderResponse.success) {
        setState(() {
          _goodsReceiptHeader = goodsReceiptHeaderResponse.data!;
          _goodsReceiptHeaderDtoBuilder = GoodsReceiptHeaderDtoBuilder.fromDto(goodsReceiptHeaderResponse.data!);
          if (_goodsReceiptHeaderDtoBuilder.transDate.isAtSameMomentAs(DateTimeHelper.minDateTime)) {
            _goodsReceiptHeaderDtoBuilder.setTransDate(DateTimeHelper.today);
          }
        });
      }
      if (_goodsReceiptHeaderDtoBuilder.isSubmitted == true) {
        final vendPackingSlipJour = await _gmkSMSServiceGroupDAL.getVendPackingSlipJourWithLines(_goodsReceiptHeaderDtoBuilder.packingSlipId);
        setState(() => _vendPackingSlipJour = vendPackingSlipJour.data!);
      }
      // final purchTableResponse = await _gmkSMSServiceGroupDAL.getPurchTable(goodsReceiptHeaderResponse.data!.purchId);
      // if (purchTableResponse.success) {
      // }
      // final purchLineResponse = await _gmkSMSServiceGroupDAL.getPurchLineList(goodsReceiptHeaderResponse.data!.purchId);
      // if (purchLineResponse.success) {
      // }
    } catch (error) {
      _scaffoldMessenger.showSnackBar(SnackBar(
        content: Text('Error fetching goods receipt header details: $error')
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveData() async {
    try {
      setState(() => _isLoading = true);
      final goodsReceiptHeaderResponse = await _goodsReceiptHeaderDAL.updateGoodsReceiptHeaderWithLines(_goodsReceiptHeaderDtoBuilder.build());
      if (goodsReceiptHeaderResponse.success) {
        _scaffoldMessenger.showSnackBar(const SnackBar(
          content: Text('Goods receipt header has been saved')
        ));
      }
      else {
        throw Exception('response is received but not successful');
      }
    } catch (error) {
      _scaffoldMessenger.showSnackBar(SnackBar(
        content: Text('Error saving goods receipt header to AX: $error')
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
        _scaffoldMessenger.showSnackBar(const SnackBar(
          content: Text('Goods receipt header posted to AX')
        ));
      }
    }
    finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> scanBarcodeNormal(GoodsReceiptLineDtoBuilder lineDtoBuilder) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    if (barcodeScanRes == '-1') {
      return;
    }

    if (barcodeScanRes.isEmpty) {
      return;
    }

    if (barcodeScanRes == lineDtoBuilder.wMSLocationId && lineDtoBuilder.inventLocationId == Environment.userWarehouseDto.inventLocationId) {
      return;
    }

    await _getWMSLocation(barcodeScanRes, lineDtoBuilder);
  }

  Future<void> _getWMSLocation(String barcodeScanRes, GoodsReceiptLineDtoBuilder lineDtoBuilder) async {
    setState(() => _isLoading = true);
    var response = await _gmkSMSServiceGroupDAL.getWMSLocation(WMSLocationDto(wMSLocationId: barcodeScanRes, inventLocationId: Environment.userWarehouseDto.inventLocationId));
    if (response.success) {
      var wMSLocationDto = response.data!;

      if (wMSLocationDto.isDefault()) {
        _scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Location $barcodeScanRes not found in warehouse ${Environment.userWarehouseDto.inventLocationId}')
        ));
      } else {
        setState(() {
          lineDtoBuilder.setInventLocationId(wMSLocationDto.inventLocationId);
          lineDtoBuilder.setWMSLocationId(wMSLocationDto.wMSLocationId);
        });
      }
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // create 2 tabs, one for the header and one for the lines
    var transDateTextController = TextEditingController(text: DateFormat("dd/MM/yyyy").format(_goodsReceiptHeaderDtoBuilder.transDate));
    return PopScope(
      canPop: _canPop || _isModified,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmationDialog(
                title: const Text('Exit'),
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
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: _goodsReceiptHeaderDtoBuilder.isSubmitted == false && tabIndex == 1 ? FloatingActionButton(
            onPressed: () async {
              var result = await _navigator.pushNamed('/goodsReceiptLineAdd', arguments: _goodsReceiptHeader);
              if (result != null) {
                var goodsReceiptLines = result as List<PurchLineDto>;
                for (var purchLine in goodsReceiptLines) {
                  _goodsReceiptHeaderDtoBuilder.addGoodsReceiptLine(purchLine);
                }
                setState(() {});
              }
            },
            child: const Icon(Icons.add),
          ) : null,
          appBar: AppBar(
            title: Text('Goods Receipt Details${_isModified ? '' : ' *'}', style: const TextStyle(fontSize: 16)),
            toolbarHeight: 50,
            bottom: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  text: 'Header',
                ),
                Tab(
                  text: 'Lines',
                ),
              ],
            ),
            actions: [
              if (!_isEditing) ...[
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed:  _goodsReceiptHeader.isSubmitted == false && _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.isNotEmpty ? () async {
                    // confirmation dialog
                    if (!_isModified) {
                      _scaffoldMessenger.showSnackBar(const SnackBar(
                        content: Text('Goods receipt header has been modified, please save first'),
                      ));
                      return;
                    }
                    await showDialog<bool>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Post to AX'),
                          content: const Text('Are you sure you want to post this goods receipt to AX?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => _navigator.pop(),
                                style: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.all(Colors.white),
                                  backgroundColor: WidgetStateProperty.all(Colors.red),
                                ),
                                child: const Text('No')
                            ),
                            TextButton(
                              onPressed: () async {
                                _navigator.pop();
                                await _postData();
                                await _fetchData();
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
                ),
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _goodsReceiptHeader.isSubmitted == false ? () async {
                    // show confirmation dialog
                    await showDialog<bool>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Save data'),
                          content: const Text('Are you sure you want to save this goods receipt as draft?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => _navigator.pop(),
                                style: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.all(Colors.white),
                                  backgroundColor: WidgetStateProperty.all(Colors.red),
                                ),
                                child: const Text('No')
                            ),
                            TextButton(
                              onPressed: () async {
                                // close confirmation dialog
                                _navigator.pop();
                                await _saveData();
                                await _fetchData();
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
                ),
              ]
              else ...[
                if (!_goodsReceiptHeaderDtoBuilder.isAllGoodsReceiptLinesSelected())
                  IconButton(
                    icon: const Icon(Icons.select_all),
                    onPressed: () {
                      setState(() {
                        _goodsReceiptHeaderDtoBuilder.selectAllGoodsReceiptLines();
                      });
                    },
                  ),
                if (_goodsReceiptHeaderDtoBuilder.isAtLeastOneGoodsReceiptLineSelected())
                IconButton(
                  icon: const Icon(Icons.deselect),
                  onPressed: () {
                    setState(() {
                      _goodsReceiptHeaderDtoBuilder.deselectAllGoodsReceiptLines();
                      _isEditing = false;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // create a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete selected lines'),
                          content: const Text('Are you sure you want to delete the selected lines?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => _navigator.pop(),
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(Colors.white),
                                backgroundColor: WidgetStateProperty.all(Colors.red),
                              ),
                              child: const Text('No')
                            ),
                            TextButton(
                              onPressed: () {
                                _navigator.pop();
                                setState(() {
                                  _goodsReceiptHeaderDtoBuilder.deleteSelectedGoodsReceiptLines();
                                  _isEditing = false;
                                });
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
                  },
                ),
              ]
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildHeaderTab(transDateTextController, context),
              _buildLineTab(),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildHeaderTab(TextEditingController transDateTextController, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Update Goods Receipt',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top:8, left: 16, bottom: 3),
            child: Text(
              'Please update the goods receipt details below',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: TextFormField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.packingSlipId),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setPackingSlipId(value),
              decoration: const InputDecoration(
                labelText: 'Product receipt',
                border: OutlineInputBorder(),
              ),
              readOnly: _goodsReceiptHeader.isSubmitted == false ? false : true
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: TextFormField(
              controller: transDateTextController,
              decoration: InputDecoration(
                labelText: 'Receipt Date',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: _goodsReceiptHeader.isSubmitted == false ? () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTimeHelper.today,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _goodsReceiptHeaderDtoBuilder.setTransDate(value);
                          transDateTextController.text = DateFormat("dd/MM/yyyy").format(value);
                        });
                      }
                    });
                  } : null,
                )
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{4}-\d{2}-\d{2}')),
              ],
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: TextFormField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.description),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setDescription(value),
              decoration: const InputDecoration(
                labelText: 'Reference GR',
                border: OutlineInputBorder(),
              ),
              readOnly: _goodsReceiptHeader.isSubmitted == false ? false : true,
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: TextFormField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.purchId),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setPurchId(value),
              decoration: const InputDecoration(
                labelText: 'PO Number',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: TextFormField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.purchName),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setPurchName(value),
              decoration: const InputDecoration(
                labelText: 'Purch Name',
              ),
              readOnly: true,
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: TextFormField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.orderAccount),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setOrderAccount(value),
              decoration: const InputDecoration(
                labelText: 'Order Account',
              ),
              readOnly: true,
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: TextFormField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.invoiceAccount),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setInvoiceAccount(value),
              decoration: const InputDecoration(
                labelText: 'Invoice Account',
              ),
              readOnly: true,
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            child: TextFormField(
              controller: TextEditingController(text: _goodsReceiptHeaderDtoBuilder.purchStatus),
              onChanged: (value) => _goodsReceiptHeaderDtoBuilder.setPurchStatus(value),
              decoration: const InputDecoration(
                labelText: 'Purch Status',
              ),
              readOnly: true,
            ),
          ),
          // Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       minimumSize: const Size.fromHeight(50)
          //     ),
          //     child: const Text('View Original Purchase Order'),
          //   )
          // ),
        ],
      ),
    );
  }

  ListView _buildLineTab() {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 1,
          color: Colors.black,
        );
      },
      padding: const EdgeInsets.only(top: 10),
      itemCount: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines.length,
      itemBuilder: (context, index) {
        _controllers.add(TextEditingController(text: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].receiveNow.toInt().toString()));
        return Theme(
          data: ThemeData(
            splashFactory: NoSplash.splashFactory,
          ),
          child: ListTile(
            title: Text(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].itemId),
            onLongPress: !_isEditing && _goodsReceiptHeaderDtoBuilder.isSubmitted == false ? () {
              setState(() {
                _isEditing = true;
                _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setIsSelected(true);
              });
            } : null,
            onTap: _isEditing ? () {
              setState(() {
                _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setIsSelected(!_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].isSelected);
              });
              if (_goodsReceiptHeaderDtoBuilder.isNoGoodsReceiptLineSelected()) {
                setState(() => _isEditing = false);
              }
            } : null,
            leading: _isEditing ? Checkbox(
              value: _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].isSelected,
              onChanged: (value) {
                setState(() {
                  _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setIsSelected(value!);
                });
                if (_goodsReceiptHeaderDtoBuilder.isNoGoodsReceiptLineSelected()) {
                  setState(() => _isEditing = false);
                }
              },
            ) : null,
            minLeadingWidth: 0,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].itemName}"),
                const SizedBox(height: 10),
                Text("Receive Qty: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].receiveNow} / ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].remainPurchPhysical}"),
                Text("Unit: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchUnit}"),
                // Text("Price: ${numberToIdr(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchPrice, 2)}"),
                // Text("Amount: ${numberToIdr(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchQty * _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].purchPrice, 2)}"),
                const SizedBox(height: 10),
                // create a button
                if (_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].productType == ProductType.item) ...[
                  Text("Warehouse: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].inventLocationId}"),
                  Text("Location: ${_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].wMSLocationId}"),
                  const SizedBox(height: 10),
                  if (!_isEditing && _goodsReceiptHeaderDtoBuilder.isSubmitted == false)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _goodsReceiptHeaderDtoBuilder.isSubmitted == false ? () {
                              _navigator.pushNamed('/wMSLocationLookup').then((value) {
                                if (value != null) {
                                  setState(() {
                                    var wMSLocationDto = value as WMSLocationDto;
                                    _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setInventLocationId(wMSLocationDto.inventLocationId);
                                    _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setWMSLocationId(wMSLocationDto.wMSLocationId);
                                  });
                                }
                              });
                            } : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              padding: const EdgeInsets.all(0),
                            ),
                            // text for the button written as Select Location with edit icon
                            child: const Icon(
                              UniconsLine.search,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _goodsReceiptHeaderDtoBuilder.isSubmitted == false ? () {
                              scanBarcodeNormal(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index]);
                            } : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              padding: const EdgeInsets.all(0)
                            ),
                            // text for the button written as Scan Location with scan icon
                            child: const Icon(
                              UniconsLine.qrcode_scan,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              _goodsReceiptLineDtoBuilderScan = _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index];
                              await Environment.zebraMethodChannel.invokeMethod("toggleSoftScan");
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              padding: const EdgeInsets.all(0)
                            ),
                            // text for the button written as Default Location with home icon
                            child: const Icon(
                              Icons.barcode_reader,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                ],
                if (!_isEditing && _goodsReceiptHeaderDtoBuilder.isSubmitted == true) ...[
                  ElevatedButton(
                    onPressed: () async {
                      // print label
                      var arguments = await _navigator.pushNamed('/printerList') as Map<String, dynamic>;
                      var printer = arguments['printer'] as BluetoothDevice;
                      var copies = arguments['copies'] as int;
                      var barcode = PrinterHelper.vendPackingSlipTemplate(
                          _vendPackingSlipJour,
                          _vendPackingSlipJour.vendPackingSlipTrans.where((element) => element.itemId == _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].itemId).single,
                          copies);
                      await PrinterHelper.printLabel(printer, barcode);
                    },
                    child:
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          UniconsLine.print,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text('Print Label'),
                      ],
                    ),
                  ),
                ]
              ],
            ),
            trailing: !_isEditing ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // minus icon
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _goodsReceiptHeaderDtoBuilder.isSubmitted == false && _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].receiveNow > 1 ? () {
                    setState(() {
                      _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setReceiveNow(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].receiveNow - 1);
                      _controllers[index].text = _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].receiveNow.toInt().toString();
                    });
                  } : null,
                ),
                // quantity text field
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    enabled: _goodsReceiptHeaderDtoBuilder.isSubmitted == false,
                    decoration: const InputDecoration(
                      labelText: 'Qty',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                    textAlign: TextAlign.center,
                    controller: _controllers[index],
                    onChanged: (value) {
                      setState(() {
                        var valueParsed = int.tryParse(value) ?? 1;
                        if (valueParsed >= 1) {
                          _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setReceiveNow(valueParsed.toDouble());
                        }
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NumericalMinFormatter(min: 1)
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
                // plus icon
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _goodsReceiptHeaderDtoBuilder.isSubmitted == false ? () {
                    setState(() {
                      _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].setReceiveNow(_goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].receiveNow + 1);
                      _controllers[index].text = _goodsReceiptHeaderDtoBuilder.goodsReceiptLines[index].receiveNow.toInt().toString();
                    });
                  } : null,
                ),
              ],
            ) : null,
          ),
        );
      },
    );
  }
}
