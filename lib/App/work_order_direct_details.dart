import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Constants/no_yes.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:unicons/unicons.dart';

class WorkOrderDirectDetails extends StatefulWidget {
  final WorkOrderHeaderDto workOrderHeaderDto;
  const WorkOrderDirectDetails({super.key, required this.workOrderHeaderDto});

  @override
  State<WorkOrderDirectDetails> createState() => _WorkOrderDirectDetailsState();
}

class _WorkOrderDirectDetailsState extends State<WorkOrderDirectDetails> with SingleTickerProviderStateMixin {
  final _workOrderDirectDAL = locator<WorkOrderDirectDAL>();
  final _workOrderHeaderDtoBuilder = WorkOrderHeaderDtoBuilder();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;
  late TabController _tabController;
  var _isLoading = false;
  //var _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    // _tabController.animation?.addListener(() => setState(() => _tabIndex = _tabController.index));
    _fetchWorkOrder();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchWorkOrder() async {
    try {
      setState(() => _isLoading = true);
      final headerResult = await _workOrderDirectDAL.getWorkOrderHeader(widget.workOrderHeaderDto.agseamwoid);
      final lineResult = await _workOrderDirectDAL.getWorkOrderLineList(widget.workOrderHeaderDto.agseamwoid);
      final workOrderLineDto = lineResult.data ?? <WorkOrderLineDto>[];
      _workOrderHeaderDtoBuilder.setFromDto(headerResult.data ?? WorkOrderHeaderDto());
      _workOrderHeaderDtoBuilder.setWorkOrderLines(workOrderLineDto.map((e) => WorkOrderLineDtoBuilder.fromDto(e)).toList());
    }
    on DioException catch (error) {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text(error.response?.data['message'] ?? error.message)));
    }
    catch (error) {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text(error.toString())));
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
        // floatingActionButton: _tabIndex == 1 ? FloatingActionButton(
        //   onPressed: () {
        //     _navigator.pushNamed('/workOrderLineAdd').then((value) => _fetchWorkOrder());
        //   },
        //   child: const Icon(Icons.add),
        // ) : null,
        appBar: AppBar(
          title: const Text('Work Order Details'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Header'),
              Tab(text: 'Lines'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _workOrderHeader(),
            _workOrderLines(),
          ],
        ),
      ),
    );
  }

  Widget _workOrderHeader() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Text(
              'Work order details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              'below are the details of the work order.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwoid),
              decoration: const InputDecoration(labelText: 'Work Order Id', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwrid),
              decoration: const InputDecoration(labelText: 'Work Request Id', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamEntityID),
              decoration: const InputDecoration(labelText: 'Entity Id', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.name),
              decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.headerTitle),
              decoration: const InputDecoration(labelText: 'Work Order Title', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamPriorityID),
              decoration: const InputDecoration(labelText: 'Priority', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwotype),
              decoration: const InputDecoration(labelText: 'Work Order Type', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwoStatusID),
              decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              // format date with intl
              controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.agseamPlanningStartDate)),
              decoration: const InputDecoration(labelText: 'Planning Start Date', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.agseamPlanningEndDate)),
              decoration: const InputDecoration(labelText: 'Planning End Date', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.woCloseDate)),
              decoration: const InputDecoration(labelText: 'Work Order Close Date', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.notes),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder()),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Entity Shut Down'),
                Switch(
                  value: _workOrderHeaderDtoBuilder.entityShutDown == NoYes.yes,
                  onChanged: (value) { },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Suspend'),
                Switch(
                  value: _workOrderHeaderDtoBuilder.agseamSuspend == NoYes.yes,
                  onChanged: (value) { },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _workOrderLines() {
    return _workOrderHeaderDtoBuilder.workOrderLines.isNotEmpty ? ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
        thickness: 1.0,
      ),
      itemCount: _workOrderHeaderDtoBuilder.workOrderLines.length,
      itemBuilder: (context, index) {
        final workOrderLine = _workOrderHeaderDtoBuilder.workOrderLines[index];
        return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Line Number: ${workOrderLine.line}"),
                Text("Line Title: ${workOrderLine.lineTitle}"),
              ],
            ),
            leading: workOrderLine.lineStatus == "Closed" ? const Icon(UniconsLine.check_circle, color: Colors.green) : IconButton(
              icon: const Icon(UniconsLine.message),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: const Text('Close Work Order Line'),
                    content: const Text('Are you sure you want to close this work order line?'),
                    onConfirm: () async {
                      try {
                        setState(() => _isLoading = true);
                        await _workOrderDirectDAL.closeWorkOrderLineAndPostInventJournal(workOrderLine.build());
                        await _fetchWorkOrder();
                      }
                      on DioException catch (error) {
                        var messages = error.response?.data['errorMessages'] as List<dynamic>;
                        _scaffoldMessenger.showSnackBar(SnackBar(content: Text(messages.first)));
                      }
                      finally {
                        setState(() => _isLoading = false);
                        _scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Work order line closed successfully')));
                      }
                    },
                  )
                );
              },
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Task id: ${workOrderLine.taskId}"),
                Text("Condition: ${workOrderLine.condition}"),
                Text("Supervisor: ${workOrderLine.supervisor}"),
                Text("Line status: ${workOrderLine.lineStatus}"),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                await _navigator.pushNamed('/workOrderDirectLineDetails', arguments: workOrderLine.build());
                await _fetchWorkOrder();
              },
            )
        );
      },
    ) : const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning, size: 100),
        Text('No data found'),
      ],
    );
  }
}
