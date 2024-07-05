import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class InventoryMasterStockList extends StatefulWidget {
  final InventTableDto inventTableDto;
  const InventoryMasterStockList({super.key, required this.inventTableDto});

  @override
  State<InventoryMasterStockList> createState() => _InventoryMasterStockListState();
}

class _InventoryMasterStockListState extends State<InventoryMasterStockList> {
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _inventLocationIdController = TextEditingController();
  final _wMSLocationIdController = TextEditingController();
  var _isLoading = false;
  var _showZeroStock = false;
  Timer? _debounce;

  final List<InventSumDto> _inventSumDtoList = <InventSumDto>[];
  var _inventSumDtoListFiltered = <InventSumDto>[];

  @override
  void initState() {
    super.initState();
    _fetchInventSumDtoList();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchInventSumDtoList() async {
    setState(() => _isLoading = true);

    final searchDto = InventSumSearchDto(
      itemId: widget.inventTableDto.itemId,
      inventLocationId: '',
      wMSLocationId: ''
    );

    final response = await _gmkSMSServiceGroupDAL.getInventSumList(searchDto);

    if (response.data != null) {
      setState(() {
        _inventSumDtoList.clear();
        _inventSumDtoList.addAll(response.data!);
      });
      await _refreshFilteredList();
    }

    setState(() => _isLoading = false);
  }

  Future<void> _refreshFilteredList() async {
    setState(() {
      _inventSumDtoListFiltered = _inventSumDtoList.where((element) {
        return element.inventLocationId.toLowerCase().contains(_inventLocationIdController.text.toLowerCase()) &&
            element.wMSLocationId.toLowerCase().contains(_wMSLocationIdController.text.toLowerCase());
      }).toList();
      if (!_showZeroStock) {
        _inventSumDtoListFiltered = _inventSumDtoListFiltered.where((element) => element.physicalInvent > 0).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stock List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _fetchInventSumDtoList,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _inventLocationIdController,
                      decoration: const InputDecoration(
                        labelText: 'Warehouse',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce = Timer(const Duration(milliseconds: 500), () {
                          _refreshFilteredList();
                        });
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _wMSLocationIdController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce = Timer(const Duration(milliseconds: 500), () {
                          _refreshFilteredList();
                        });
                      }
                    ),
                  ),
                  // create a toggle button to show zero stock
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Text('Show Zero Stock'),
                        Switch(
                          value: _showZeroStock,
                          onChanged: (value) {
                            setState(() {
                              _showZeroStock = value;
                              _refreshFilteredList();
                            });
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _inventLocationIdController.text.isEmpty && _wMSLocationIdController.text.isEmpty ? null : () {
                            _inventLocationIdController.clear();
                            _wMSLocationIdController.clear();
                            _refreshFilteredList();
                          },
                          child: const Text('Clear Filter'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  );
                },
                itemCount: _inventSumDtoListFiltered.length,
                itemBuilder: (context, index) {
                  final inventSumDto = _inventSumDtoListFiltered[index];
                  return ListTile(
                    dense: false,
                    title: Text("${inventSumDto.inventLocationId} - ${inventSumDto.wMSLocationId}"),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('Physical Inventory'),
                              const Spacer(),
                              Text('${inventSumDto.physicalInvent}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Physical Reserved'),
                              const Spacer(),
                              Text('${inventSumDto.reservPhysical}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Available Physical'),
                              const Spacer(),
                              Text('${inventSumDto.availPhysical}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Ordered in Total'),
                              const Spacer(),
                              Text('${inventSumDto.orderedSum}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('On Order'),
                              const Spacer(),
                              Text('${inventSumDto.onOrder}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Ordered Reserved'),
                              const Spacer(),
                              Text('${inventSumDto.reservOrdered}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Total Available'),
                              const Spacer(),
                              Text('${inventSumDto.availOrdered}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
