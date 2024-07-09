import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Constants/no_yes.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkOrderDetails extends StatefulWidget {
  final WorkOrderHeaderDto workOrderHeaderDto;
  const WorkOrderDetails({super.key, required this.workOrderHeaderDto});

  @override
  State<WorkOrderDetails> createState() => _WorkOrderDetailsState();
}

class _WorkOrderDetailsState extends State<WorkOrderDetails> with SingleTickerProviderStateMixin {
  final _workOrderDAL = locator<WorkOrderDAL>();
  final _workOrderHeaderDtoBuilder = WorkOrderHeaderDtoBuilder();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;
  late TabController _tabController;
  var _isLoading = false;
  var _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
      _tabController.animation?.addListener(() => setState(() => _tabIndex = _tabController.index));
      _workOrderHeaderDtoBuilder.setFromDto(widget.workOrderHeaderDto);
      _fetchWorkOrderLine();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchWorkOrderLine() async {
    try {
      setState(() => _isLoading = true);
      final result = await _workOrderDAL.getWorkOrderLineByWorkOrderHeaderId(widget.workOrderHeaderDto.workOrderHeaderId);
      final workOrderLineDto = result.data ?? <WorkOrderLineDto>[];
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
        floatingActionButton: _tabIndex == 1 ? FloatingActionButton(
          onPressed: () {
            _navigator.pushNamed('/workOrderLineAdd').then((value) => _fetchWorkOrderLine());
          },
          child: const Icon(Icons.add),
        ) : null,
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
              'New Goods Receipt',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Text(
              'Please fill the form below to create new Goods Receipt Header.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwoid),
              decoration: const InputDecoration(labelText: 'Work Order Id'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwrid),
              decoration: const InputDecoration(labelText: 'Work Request Id'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamEntityID),
              decoration: const InputDecoration(labelText: 'Entity Id'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.name),
              decoration: const InputDecoration(labelText: 'Name'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.headerTitle),
              decoration: const InputDecoration(labelText: 'Work Order Title'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamPriorityID),
              decoration: const InputDecoration(labelText: 'Priority'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwotype),
              decoration: const InputDecoration(labelText: 'Work Order Type'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwoStatusID),
              decoration: const InputDecoration(labelText: 'Status'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              // format date with intl
              controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.agseamPlanningStartDate)),
              decoration: const InputDecoration(labelText: 'Planning Start Date'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.agseamPlanningEndDate)),
              decoration: const InputDecoration(labelText: 'Planning End Date'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.woCloseDate)),
              decoration: const InputDecoration(labelText: 'Work Order Close Date'),
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
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
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: <Widget>[
                const Text('Suspend'),
                Switch(
                  value: _workOrderHeaderDtoBuilder.agseamSuspend == NoYes.yes,
                  onChanged: (value) { },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              controller: TextEditingController(text: _workOrderHeaderDtoBuilder.notes),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(labelText: 'Notes'),
              readOnly: true,
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
          title: Text("Line number: ${workOrderLine.line}"),
          subtitle: Text("Task ID: ${workOrderLine.taskId}"),
          trailing: IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              _navigator.pushNamed('/itemRequisitionList', arguments: workOrderLine.workOrderLineId).then((value) => _fetchWorkOrderLine());
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
