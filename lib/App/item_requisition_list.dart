import 'package:flutter/material.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/item_requisition_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class ItemRequisitionList extends StatefulWidget {
  final int workOrderLineId;
  const ItemRequisitionList({super.key, required this.workOrderLineId});

  @override
  State<ItemRequisitionList> createState() => _ItemRequisitionListState();
}

class _ItemRequisitionListState extends State<ItemRequisitionList> {
  final _workOrderDAL = locator<WorkOrderDAL>();
  final _itemRequisitionList = <ItemRequisitionDto>[];
  late NavigatorState _navigator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });
    _loadItemRequisitionList();
  }

  Future<void> _loadItemRequisitionList() async {
    final response = await _workOrderDAL.getItemRequisitionByWorkOrderLineId(widget.workOrderLineId);
    if (response.success) {
      setState(() {
        _itemRequisitionList.clear();
        _itemRequisitionList.addAll(response.data!);
      });
    }
  }

  Future<void> _addNewItemRequisition() async {
    final response = await _workOrderDAL.addItemRequisition(ItemRequisitionDto(workOrderLineId: widget.workOrderLineId));
    if (response.success) {
      _loadItemRequisitionList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigator.pushNamed('/itemRequisitionAdd'),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Item Requirement List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _addNewItemRequisition,
          ),
        ],
      ),
      body: Center(
        child: _itemRequisitionList.isEmpty
            ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No item requisition found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text('Click the plus icon to add a new item requisition', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
              ],
            )
            : ListView.separated(
            itemBuilder: (context, index) {
              final itemRequisition = _itemRequisitionList[index];
              return ListTile(
                title: Text("Item Id: ${itemRequisition.itemId}"),
                subtitle: Text("Item Name: ${itemRequisition.itemName}"),
                trailing: Text("Quantity: ${itemRequisition.quantity}"),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: _itemRequisitionList.length
        ),
      )
    );
  }
}
