import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/item_requisition_dto_builder.dart';

class ItemRequisitionAdd extends StatefulWidget {
  const ItemRequisitionAdd({super.key});

  @override
  State<ItemRequisitionAdd> createState() => _ItemRequisitionAddState();
}

class _ItemRequisitionAddState extends State<ItemRequisitionAdd> {
  final _itemRequisitionDtoBuilder = ItemRequisitionDtoBuilder();
  final _formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
    });
  }

  Future<void> _saveItemRequisition() async {
    try {
      // save the item requisition
      _scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Item requisition added successfully')
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        controller: TextEditingController(text: _itemRequisitionDtoBuilder.itemId),
                        decoration: InputDecoration(
                          labelText: 'Item Id',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () async {
                              final item = await _navigator.pushNamed('/inventTableLookup') as InventTableDto;
                              setState(() {
                                _itemRequisitionDtoBuilder.setItemId(item.itemId);
                                _itemRequisitionDtoBuilder.setItemName(item.productName);
                              });
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
                        controller: TextEditingController(text: _itemRequisitionDtoBuilder.itemName),
                        decoration: const InputDecoration(
                          labelText: 'Item Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an Item Name';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null && value is double) {
                            _itemRequisitionDtoBuilder.setQuantity(value as double);
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Request Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a request quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null && value is double) {
                            _itemRequisitionDtoBuilder.setRequestQuantity(value as double);
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: _itemRequisitionDtoBuilder.requiredDate.isAfter(DateTimeHelper.minDateTime) ? DateFormat('dd MMMM yyyy').format(_itemRequisitionDtoBuilder.requiredDate) : ''),
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
                            initialDate: _itemRequisitionDtoBuilder.requiredDate.isAfter(DateTimeHelper.minDateTime) ? _itemRequisitionDtoBuilder.requiredDate : DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setState(() => _itemRequisitionDtoBuilder.setRequiredDate(date));
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
                                  controller: TextEditingController(text: _itemRequisitionDtoBuilder.inventLocationId),
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
                                  controller: TextEditingController(text: _itemRequisitionDtoBuilder.wMSLocationId),
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
                                    final location = await _navigator.pushNamed('/wMSLocationLookup') as WMSLocationDto;
                                    setState(() {
                                      _itemRequisitionDtoBuilder.setInventLocationId(location.inventLocationId);
                                      _itemRequisitionDtoBuilder.setWMSLocationId(location.wMSLocationId);
                                    });
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
                          // SizedBox(
                          //   width: 100,
                          //   child: IconButton(
                          //     style: ButtonStyle(
                          //       padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                          //
                          //     ),
                          //     icon: const Icon(Icons.warehouse, size: 50),
                          //     onPressed: () async {
                          //       final location = await _navigator.pushNamed('/wMSLocationLookup') as WMSLocationDto;
                          //       setState(() {
                          //         _itemRequisitionDtoBuilder.setInventLocationId(location.inventLocationId);
                          //         _itemRequisitionDtoBuilder.setWMSLocationId(location.wMSLocationId);
                          //       });
                          //     },
                          //   ),
                          // ),
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
    );
  }
}
