import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Constants/no_yes.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';

import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto_builder.dart';

class ItemRequisitionDirectList extends StatefulWidget {
  final WorkOrderLineDto workOrderLineDto;
  const ItemRequisitionDirectList({super.key, required this.workOrderLineDto});

  @override
  State<ItemRequisitionDirectList> createState() => _ItemRequisitionDirectListState();
}

class _ItemRequisitionDirectListState extends State<ItemRequisitionDirectList> {
  final _workOrderDirectDAL = locator<WorkOrderDirectDAL>();
  final _inventReqDtoBuilder = <InventReqDtoBuilder>[];
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;
  var _isLoading = false;
  var _isDeleting = false;

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
          _inventReqDtoBuilder.clear();
          _inventReqDtoBuilder.addAll(response.data!.map((e) => InventReqDtoBuilder.fromDto(e)));
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

  Future<void> _createInventJournalTable() async {
    try {
      setState(() => _isLoading = true);
      final response = await _workOrderDirectDAL.createInventJournalTable(widget.workOrderLineDto);
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text(response.message)));
    } on DioException catch (e) {
      if (e.response?.data['errorMessages'] is List) {
        var message = e.response?.data['errorMessages'] as List<dynamic>;
        _scaffoldMessenger.showSnackBar(SnackBar(content: Text(message.first)));
      } else if (e.response?.data["errorMessages"] != null && e.response?.data['errorMessages'] is String) {
        var message = e.response?.data['errorMessages'] as String;
        _scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
      }
    }
    finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteItemRequisition() async {
    try {
      setState(() => _isLoading = true);
      final response = await _workOrderDirectDAL.deleteItemRequisitionWithListOfRecId(_inventReqDtoBuilder.where((element) => element.isSelected).map((e) => e.recId).toList());
      if (response.success) {
        _scaffoldMessenger.showSnackBar(SnackBar(content: Text(response.message)));
        await _loadItemRequisitionList();
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
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        floatingActionButton: _isLoading || _isDeleting ? null : FloatingActionButton(
          onPressed: () async {
            await _navigator.pushNamed('/itemRequisitionDirectDetails', arguments: { 'workOrderLineDto': widget.workOrderLineDto });
            await _loadItemRequisitionList();
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Item Requirements'),
          actions: [
            if (_inventReqDtoBuilder.where((element) => element.process == NoYes.no).isNotEmpty && !_isDeleting) ...[
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  // confirmation dialog with Cancel and Submit buttons with white text and with background color red and green respectively.
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialog(
                      title: const Text('Confirmation'),
                      content: const Text('Are you sure you want to submit the item requisition?'),
                      onConfirm: () async {
                        Navigator.of(context).pop();
                        await _createInventJournalTable();
                        await _loadItemRequisitionList();
                      },
                    ),
                    // builder: (context) => AlertDialog(
                    //   title: const Text('Confirmation'),
                    //   content: const Text('Are you sure you want to submit the item requisition?'),
                    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    //   actions: [
                    //     TextButton(
                    //       onPressed: () => Navigator.of(context).pop(),
                    //       // text button style with background color red, white text color, and small border radius
                    //       style: TextButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    //       child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                    //     ),
                    //     TextButton(
                    //       onPressed: () async {
                    //         Navigator.of(context).pop();
                    //         await _createInventJournalTable();
                    //         await _loadItemRequisitionList();
                    //       },
                    //       // text button style with background color green, white text color, and small border radius
                    //       style: TextButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    //       child: const Text('Submit', style: TextStyle(color: Colors.white)),
                    //     ),
                    //   ],
                    // ),
                  );
                },
              )
            ],
            if (_isDeleting) ...[
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  for (var element in _inventReqDtoBuilder) {
                    element.setIsSelected(false);
                  }
                  setState(() => _isDeleting = false);
                },
              )
            ],
            if (_inventReqDtoBuilder.where((element) => element.isSelected).isNotEmpty && _isDeleting) ...[
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  // confirmation dialog with Cancel and Delete buttons with white text and with background color red and green respectively.
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialog(
                      content: const Text('Are you sure you want to delete the selected item requisition?'),
                      onConfirm: () async {
                        Navigator.of(context).pop();
                        await _deleteItemRequisition();
                        setState(() => _isDeleting = false);
                      },
                    ),
                  );
                },
              )
            ],
          ]
        ),
        body: RefreshIndicator(
          onRefresh: _loadItemRequisitionList,
          child: Center(
            child: _inventReqDtoBuilder.isEmpty && !_isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No item requisition found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    Text('Click the plus icon to add a new item requisition', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
                  ],
              ) : ListView.separated(
                itemBuilder: (context, index) {
                  final inventReqDto = _inventReqDtoBuilder[index];
                  return ListTile(
                    title: Text("Item Id: ${inventReqDto.itemId}"),
                    minLeadingWidth: 0,
                    onLongPress: _inventReqDtoBuilder.where((element) => element.process == NoYes.no).isEmpty ? null : () {
                      setState(() {
                        _isDeleting = true;
                        if (inventReqDto.process == NoYes.no) {
                          inventReqDto.setIsSelected(true);
                        }
                      });
                    },
                    onTap: _isDeleting && inventReqDto.process == NoYes.no ? () {
                      setState(() => inventReqDto.setIsSelected(!inventReqDto.isSelected));
                    } : null,
                    leading: _isDeleting && inventReqDto.process == NoYes.no ? Checkbox(
                      value: inventReqDto.isSelected,
                      onChanged: (value) async {
                        if (value == null) return;
                        setState(() => inventReqDto.setIsSelected(value));
                      },
                    ) : null,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Item Name: ${inventReqDto.productName}"),
                        Text("Preparer: ${inventReqDto.preparerUserId}"),
                      ],
                    ),
                    trailing: inventReqDto.process == NoYes.yes ? const Column(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        Text("Processed"),
                      ],
                    ) : _isDeleting ? null : IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Edit',
                      onPressed: () async {
                        await _navigator.pushNamed('/itemRequisitionDirectDetails', arguments: { 'workOrderLineDto': widget.workOrderLineDto, 'inventReqDto': inventReqDto.build() });
                        await _loadItemRequisitionList();
                      },
                    )
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _inventReqDtoBuilder.length
              ),
          ),
        )
      ),
    );
  }
}
