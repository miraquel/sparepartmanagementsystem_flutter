import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class ItemRequisitionDirectAdd extends StatefulWidget {
  final WorkOrderLineDto workOrderLineDto;
  const ItemRequisitionDirectAdd({super.key, required this.workOrderLineDto});

  @override
  State<ItemRequisitionDirectAdd> createState() => _ItemRequisitionDirectAddState();
}

class _ItemRequisitionDirectAddState extends State<ItemRequisitionDirectAdd> {
  final _workOrderDirectDAL = locator<WorkOrderDirectDAL>();
  final _inventReqDto = InventReqDtoBuilder();
  final _formKey = GlobalKey<FormState>();
  var _maxQuantity = 0.0;
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
    });

    _inventReqDto.setAgswoRecId(widget.workOrderLineDto.recId);
    _inventReqDto.setInventSiteId(Environment.userWarehouseDto.inventSiteId);
  }

  Future<void> _saveItemRequisition() async {
    try {
      setState(() => _isLoading = true);
      // save the item requisition
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
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

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Item Requisition'),
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
                      children: [
                        // add form fields here
                        TextFormField(
                          controller: TextEditingController(text: _inventReqDto.itemId),
                          decoration: InputDecoration(
                            labelText: 'Item Id',
                            suffixIcon: IconButton(
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
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an Item Id';
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                        TextFormField(
                          controller: TextEditingController(text: _inventReqDto.productName),
                          decoration: const InputDecoration(
                            labelText: 'Item Name',
                          ),
                          readOnly: true,
                        ),
                        TextFormField(
                          controller: TextEditingController(text: NumberFormat("#.#").format(_inventReqDto.qty)),
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty || double.tryParse(value) == 0) {
                              return 'Please enter a quantity';
                            }
                            if (double.tryParse(value)! > _maxQuantity) {
                              return 'Quantity cannot be more than $_maxQuantity';
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
                        TextFormField(
                          controller: TextEditingController(text: _inventReqDto.requiredDate.isAfter(DateTimeHelper.minDateTime) ? DateFormat('dd MMMM yyyy').format(_inventReqDto.requiredDate) : ''),
                          decoration: const InputDecoration(
                            labelText: 'Required Date',
                            suffixIcon: Icon(Icons.calendar_today),
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
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a site';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(text: _inventReqDto.wmsLocationId),
                                      decoration: const InputDecoration(
                                        labelText: 'Warehouse Location',
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
                                    border: Border.all(width: 1.5),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      final location = await _navigator.pushNamed('/itemRequisitionDirectAddLocation', arguments: _inventReqDto.itemId) as InventSumDto?;
                                      if (location != null) {
                                        setState(() {
                                          _inventReqDto.setInventLocationId(location.inventLocationId);
                                          _inventReqDto.setWmsLocationId(location.wMSLocationId);
                                          _maxQuantity = location.availPhysical;
                                        });
                                      }
                                    },
                                    child: const Padding(
                                      padding:EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.warehouse,
                                        size: 40.0,
                                      ),
                                    ),
                                  ),
                                )
                              ),
                            ),
                          ],
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
                  onPressed: _saveItemRequisition,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Save')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
