import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';

import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class ItemRequisitionDirectList extends StatefulWidget {
  final WorkOrderLineDto workOrderLineDto;
  const ItemRequisitionDirectList({super.key, required this.workOrderLineDto});

  @override
  State<ItemRequisitionDirectList> createState() => _ItemRequisitionDirectListState();
}

class _ItemRequisitionDirectListState extends State<ItemRequisitionDirectList> {
  final _workOrderDirectDAL = locator<WorkOrderDirectDAL>();
  final _inventReqDto = <InventReqDto>[];
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
    _loadItemRequisitionList();
  }

  Future<void> _loadItemRequisitionList() async {
    try {
      setState(() => _isLoading = true);
      final response = await _workOrderDirectDAL.getItemRequisitionList(widget.workOrderLineDto.recId);
      if (response.success) {
        setState(() {
          _inventReqDto.clear();
          _inventReqDto.addAll(response.data!);
        });
      } else {
        _scaffoldMessenger.showSnackBar(SnackBar(content: Text(response.message)));
      }
    } catch (e) {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
    finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _navigator.pushNamed('/itemRequisitionDirectAdd', arguments: widget.workOrderLineDto);
          await _loadItemRequisitionList();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Item Requirement List'),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) :
      RefreshIndicator(
        onRefresh: _loadItemRequisitionList,
        child: Center(
          child: _inventReqDto.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No item requisition found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  Text('Click the plus icon to add a new item requisition', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
                ],
            ) : ListView.separated(
              itemBuilder: (context, index) {
                final inventReqDto = _inventReqDto[index];
                return ListTile(
                  title: Text("Item Id: ${inventReqDto.itemId}"),
                  subtitle: Text("Item Name: ${inventReqDto.productName}"),
                  trailing: Text("Quantity: ${inventReqDto.qty}"),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _inventReqDto.length
            ),
        ),
      )
    );
  }
}
