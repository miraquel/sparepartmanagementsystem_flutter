import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:unicons/unicons.dart';

class ItemRequisitionDirectDetails extends StatefulWidget {
  final WorkOrderLineDto workOrderLineDto;
  final InventReqDto? inventReqDto;
  const ItemRequisitionDirectDetails({super.key, required this.workOrderLineDto, this.inventReqDto});

  @override
  State<ItemRequisitionDirectDetails> createState() => _ItemRequisitionDirectDetailsState();
}

class _ItemRequisitionDirectDetailsState extends State<ItemRequisitionDirectDetails> {
  final _workOrderDirectDAL = locator<WorkOrderDirectDAL>();
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _inventReqDto = InventReqDtoBuilder();
  final _formKey = GlobalKey<FormState>();
  var _maxQuantity = 0.0;
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;
  var _isLoading = false;
  var _inventSumSearchDto = InventSumSearchDto();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
    });

    if (widget.inventReqDto != null) {
      _inventReqDto.setFromInventReqDto(widget.inventReqDto!);
    }
    else {
      _inventReqDto.setAgswoRecId(widget.workOrderLineDto.recId);
      _inventReqDto.setInventSiteId(Environment.userWarehouseDto.inventSiteId);
    }

    if (_inventReqDto.inventLocationId.isNotEmpty && _inventReqDto.wmsLocationId.isNotEmpty) {
      _getInventSum();
    }
  }

  Future<void> _getInventSum() async {
    try {
      setState(() => _isLoading = true);
      _inventSumSearchDto = InventSumSearchDto(itemId: _inventReqDto.itemId, inventLocationId: _inventReqDto.inventLocationId, wMSLocationId: _inventReqDto.wmsLocationId);
      final response = await _gmkSMSServiceGroupDAL.getInventSumList(_inventSumSearchDto);
      response.data!.removeWhere((element) => element.availPhysical == 0);
      if (response.success) {
        setState(() {
          _maxQuantity = response.data!.first.availPhysical;
        });
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveItemRequisition() async {
    try {
      setState(() => _isLoading = true);
      var response = await _workOrderDirectDAL.addItemRequisition(_inventReqDto.build());
      _scaffoldMessenger.showSnackBar(
        SnackBar(
            content: Text(response.message)
        ),
      );
      _navigator.pop();
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

  Future<void> _updateItemRequisition() async {
    try {
      setState(() => _isLoading = true);
      var response = await _workOrderDirectDAL.updateItemRequisition(_inventReqDto.build());
      _scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(response.message)
        ),
      );
      _navigator.pop();
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
          title: Text(widget.inventReqDto == null ? 'Add Item Requisition' : 'Edit Item Requisition'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // add form fields here
                        TextFormField(
                          controller: TextEditingController(text: _inventReqDto.itemId),
                          decoration: InputDecoration(
                            labelText: 'Item Id',
                            border: const OutlineInputBorder(),
                            suffixIcon: widget.inventReqDto != null ? null : Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.search),
                                  onPressed: () async {
                                    final item = await _navigator.pushNamed('/inventTableLookup') as InventTableDto?;
                                    if (item != null) {
                                      setState(() {
                                        _inventReqDto.setItemId(item.itemId);
                                        _inventReqDto.setProductName(item.productName);
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(UniconsLine.qrcode_scan),
                                  onPressed: () async {
                                    // barcode scanner
                                    final barcode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
                                    if (barcode != '-1') {
                                      final result = await _gmkSMSServiceGroupDAL.getInventTable(barcode);
                                      if (result.success && result.data != null) {
                                        final item = result.data!;
                                        setState(() {
                                          _inventReqDto.setItemId(item.itemId);
                                          _inventReqDto.setProductName(item.productName);
                                        });
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an Item Id';
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: TextEditingController(text: _inventReqDto.productName),
                          decoration: const InputDecoration(
                            labelText: 'Item Name',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        if (_inventReqDto.preparerUserId.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: TextEditingController(text: _inventReqDto.preparerUserId),
                            decoration: const InputDecoration(
                              labelText: 'Preparer',
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                          )
                        ],
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: TextEditingController(text: _inventReqDto.requiredDate.isAfter(DateTimeHelper.minDateTime) ? DateFormat('dd MMMM yyyy').format(_inventReqDto.requiredDate) : ''),
                          decoration: const InputDecoration(
                            labelText: 'Required Date',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a required date';
                            }
                            return null;
                          },
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _inventReqDto.requiredDate.isAfter(DateTimeHelper.minDateTime) ? _inventReqDto.requiredDate : DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() => _inventReqDto.setRequiredDate(date));
                            }
                          },
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: TextEditingController(text: _inventReqDto.inventLocationId),
                                      decoration: const InputDecoration(
                                        labelText: 'Site',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a site';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: TextEditingController(text: _inventReqDto.wmsLocationId),
                                      decoration: const InputDecoration(
                                        labelText: 'Warehouse Location',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a warehouse location';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                    ),
                                  ],
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 7.5),
                              child: Material(
                                type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
                                child: Ink(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: _inventReqDto.itemId.isEmpty ? Colors.grey : Colors.black),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: InkWell(
                                    onTap: _inventReqDto.itemId.isEmpty ? null : () async {
                                      final location = await _navigator.pushNamed('/itemRequisitionDirectAddLocation', arguments: _inventReqDto.itemId) as InventSumDto?;
                                      if (location != null) {
                                        setState(() {
                                          _inventReqDto.setInventLocationId(location.inventLocationId);
                                          _inventReqDto.setWmsLocationId(location.wMSLocationId);
                                          _maxQuantity = location.availPhysical;
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.warehouse,
                                        size: 40.0,
                                        color: _inventReqDto.itemId.isEmpty ? Colors.grey : Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: _maxQuantity > 0,
                          child: Text('Maximum Quantity: ${NumberFormat("#.#").format(_maxQuantity)}'),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          enabled: _inventReqDto.inventLocationId.isNotEmpty && _inventReqDto.wmsLocationId.isNotEmpty,
                          controller: TextEditingController(text: NumberFormat("#.#").format(_inventReqDto.qty)),
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value != null) {
                              var doubleValue = double.tryParse(value) ?? 0;
                              if (doubleValue <= 0) {
                                return 'Quantity must be more than 0';
                              }
                              if (doubleValue > _maxQuantity) {
                                return 'Quantity cannot be more than ${NumberFormat("#.#").format(_maxQuantity)}';
                              }
                            }
                            return null;
                          },
                          onChanged: (value) {
                            var doubleValue = double.tryParse(value);
                            if (doubleValue != null) {
                              _inventReqDto.setQty(doubleValue);
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                //onPressed: widget.inventReqDto == null ? _saveItemRequisition : _updateItemRequisition,
                // confirmation dialog
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();

                  showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialog(
                      title: const Text('Confirmation'),
                      content: const Text('Are you sure you want to continue?'),
                      onConfirm: () async {
                        _navigator.pop();
                        if (widget.inventReqDto == null) {
                          await _saveItemRequisition();
                        }
                        else {
                          await _updateItemRequisition();
                        }
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(widget.inventReqDto == null ? 'Save' : 'Update'),
              )
            ),
          ],
        ),
      ),
    );
  }
}
