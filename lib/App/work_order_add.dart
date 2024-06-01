import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Constants/no_yes.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_ax_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkOrderAdd extends StatefulWidget {
  const WorkOrderAdd({super.key});

  @override
  State<WorkOrderAdd> createState() => _WorkOrderAddState();
}

class _WorkOrderAddState extends State<WorkOrderAdd> with SingleTickerProviderStateMixin {
  final _workOrderDAL = locator<WorkOrderDAL>();
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _logger = locator<Logger>();
  final _workOrderHeaderDtoBuilder = WorkOrderHeaderDtoBuilder.forInput();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;
  late TabController _tabController;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _saveWorkOrder() async {
    try {
      setState(() => _isLoading = true);
      var result = await _workOrderDAL.addWorkOrderHeaderWithLines(_workOrderHeaderDtoBuilder.build());
      if (result.success) {
        _scaffoldMessenger.showSnackBar(SnackBar(content: Text(result.message)));
        _logger.i(result.message);
        _navigator.pop();
      } else {
        throw Exception(result.errorMessages);
      }
    } on DioException catch (error) {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text('An error occurred while adding Work Order, error: $error')));
      _logger.e('An error occurred while adding Work Order', error: error);
    } catch (error) {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text('An error occurred while adding Work Order, error: $error')));
      _logger.e('An error occurred while adding Work Order', error: error);
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
          title: const Text('Work Order Add'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: 'Header'),
              Tab(text: 'Lines'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _headerTab(),
            _linesTab(),
          ]
        )
      ),
    );
  }

  ListView _linesTab() {
    return ListView.builder(
      itemCount: _workOrderHeaderDtoBuilder.workOrderLines.length,
      itemBuilder: (context, index) {
        var line = _workOrderHeaderDtoBuilder.workOrderLines[index];
        return ListTile(
          title: Text("Line Number: ${line.line}"),
          subtitle: Text(line.lineTitle)
        );
      },
    );
  }

  Form _headerTab() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
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
                        decoration: InputDecoration(
                          labelText: 'Work Order Id',
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var result = await _navigator.pushNamed('/workOrderLookup');
                              if (result != null) {
                                var workOrderDto = result as WorkOrderAxDto;
                                setState(() => _workOrderHeaderDtoBuilder.setFromWorkOrderDto(workOrderDto));
                                var lines = await _gmkSMSServiceGroupDAL.getWorkOrderLineList(_workOrderHeaderDtoBuilder.agseamwoid);
                                if (lines.data != null && lines.data!.isNotEmpty) {
                                  setState(() => _workOrderHeaderDtoBuilder.setWorkOrderLines(lines.data!.map((e) => WorkOrderLineDtoBuilder.fromWorkOrderLineAxDto(e)).toList()));
                                }
                              }
                            },
                            icon: const Icon(Icons.search),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please select Work Order Id';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwrid),
                        decoration: const InputDecoration(labelText: 'Work request Id'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setAgseamwrid(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Work request Id';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamEntityID),
                        decoration: const InputDecoration(labelText: 'Entity Id'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setAgseamEntityID(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Entity Id';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _workOrderHeaderDtoBuilder.name),
                        decoration: const InputDecoration(labelText: 'Name'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setName(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _workOrderHeaderDtoBuilder.headerTitle),
                        decoration: const InputDecoration(labelText: 'Work Order Title'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setHeaderTitle(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Work Order Title';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamPriorityID),
                        decoration: const InputDecoration(labelText: 'Priority'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setAgseamPriorityID(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Priority';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwotype),
                        decoration: const InputDecoration(labelText: 'Work Order Type'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setAgseamwotype(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Work Order Type';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: _workOrderHeaderDtoBuilder.agseamwoStatusID),
                        decoration: const InputDecoration(labelText: 'Status'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setAgseamwoStatusID(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Status';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        // format date with intl
                        controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.agseamPlanningStartDate)),
                        decoration: const InputDecoration(labelText: 'Planning Start Date'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setAgseamPlanningStartDate(DateTime.parse(value)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Planning Start Date';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.agseamPlanningEndDate)),
                        decoration: const InputDecoration(labelText: 'Planning End Date'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setAgseamPlanningEndDate(DateTime.parse(value)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Planning End Date';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: DateFormat.yMd().add_jm().format(_workOrderHeaderDtoBuilder.woCloseDate)),
                        decoration: const InputDecoration(labelText: 'Work Order Close Date'),
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setWoCloseDate(DateTime.parse(value)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Work Order Close Date';
                          }
                          return null;
                        },
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
                        onChanged: (value) => _workOrderHeaderDtoBuilder.setNotes(value),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter Notes';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _saveWorkOrder,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)
                ),
                child: const Text('Save'),
              ),
            ),
          ]
        ),
      );
  }
}
