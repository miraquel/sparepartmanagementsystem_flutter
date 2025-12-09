import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_request_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/eam_workflow_status.dart';
import 'package:sparepartmanagementsystem_flutter/Model/eam_condition_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/eam_task_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/WorkRequest/work_request_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkRequestDetails extends ConsumerStatefulWidget {
  const WorkRequestDetails({super.key, required String agseamWrId}) : _agseamWrId = agseamWrId;

  final String _agseamWrId;

  @override
  ConsumerState<WorkRequestDetails> createState() => _WorkRequestDetailsState();
}

class _WorkRequestDetailsState extends ConsumerState<WorkRequestDetails> {
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _taskIdController = TextEditingController();
  final TextEditingController _wrkCtrIdController = TextEditingController();
  final _workRequestDal = locator<WorkRequestDal>();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Zebra scanner device, only for Android devices
    // It is only activated when adding a new item requisition
    if (Platform.isAndroid)
    {
      Environment.zebraMethodChannel.invokeMethod("registerReceiver");
      Environment.zebraMethodChannel.setMethodCallHandler((call) async {
        if (call.method == "displayScanResult") {
          var scanData = call.arguments["scanData"];
          if (scanData != null) {
            await _validateWrkCtrId(scanData);
          }
        }
        if (call.method == "showToast") {
          ref.read(snackbarMessageProvider.notifier).show(call.arguments["message"]);
        }
        return null;
      });
    }
    // end - Zebra scanner device
  }

  Future<bool> _validateWrkCtrId(String wrkCtrId) async {
    var valid = await ref.read(workRequestProvider(widget._agseamWrId).notifier).validateWrkCtrId(wrkCtrId);
    if (valid) {
      setState(() => _wrkCtrIdController.text = wrkCtrId);
    } else {
      ref.read(snackbarMessageProvider.notifier).show("Invalid Work Center ID: $wrkCtrId");
    }

    return valid;
  }

  @override
  void dispose() {
    _conditionController.dispose();
    _taskIdController.dispose();
    _wrkCtrIdController.dispose();

    // Unregister Zebra scanner receiver
    if (Platform.isAndroid) {
      Environment.zebraMethodChannel.invokeMethod("unregisterReceiver");
    }

    super.dispose();
  }

  bool validateCreateWorkOrder(WorkRequestDto workRequest) {
    if (workRequest.agseamCondition == null || workRequest.agseamCondition!.isEmpty) {
      return false;
    }
    if (workRequest.agseamTaskID == null || workRequest.agseamTaskID!.isEmpty) {
      return false;
    }
    if (workRequest.wrkCtrId == null || workRequest.wrkCtrId!.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<WorkRequestDto> workRequest = ref.watch(workRequestProvider(widget._agseamWrId));

    // show snackbar after accepting work request
    ref.listen<String?>(snackbarMessageProvider, (prev, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Request Details'),
      ),
      body: workRequest.when(
        data: (workRequest) {
          // Initialize controllers with existing work request data
          if (!_isInitialized) {
            _isInitialized = true;
            _conditionController.text = workRequest.agseamCondition ?? '';
            _taskIdController.text = workRequest.agseamTaskID ?? '';
            _wrkCtrIdController.text = workRequest.wrkCtrId ?? '';
          }
          // Build the UI for work request details
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // Header for Work Request Details with grey background
                    Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Work Request Details',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: const Text('Work Request ID'),
                      subtitle: Text(workRequest.agseamwrid ?? ''),
                    ),
                    ListTile(
                      title: const Text('Work Request Title'),
                      subtitle: Text(workRequest.wrTitle ?? ''),
                    ),
                    ListTile(
                      title: const Text('Work Request Notes'),
                      subtitle: Text(workRequest.wrNotes ?? ''),
                    ),
                    ListTile(
                      title: const Text('Entity ID'),
                      subtitle: Text(workRequest.agseamEntityID ?? ''),
                    ),
                    ListTile(
                      title: const Text('Entity Name'),
                      subtitle: Text(workRequest.agseamEntityName ?? ''),
                    ),
                    ListTile(
                      title: const Text('Requestor'),
                      subtitle: Text(workRequest.requestorName ?? ''),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Input Fields',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          DropdownSearch<EamConditionDto>(
                            validator:(value) {
                              if (value == null) {
                                return 'Please select Condition';
                              }
                              return null;
                            },
                            compareFn: (item, selectedItem) => item == selectedItem,
                            popupProps: PopupPropsMultiSelection.menu(
                              showSearchBox: true,
                              itemBuilder: (BuildContext context, EamConditionDto item, bool isDisabled, bool isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: !isSelected
                                      ? null
                                      : BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: ListTile(
                                    selected: isSelected,
                                    dense: true,
                                    title: Text(item.condition ?? '', style: TextStyle(fontSize: 16)),
                                    contentPadding: const EdgeInsets.all(8),
                                    subtitle: Text(item.description ?? '')
                                  ),
                                );
                              },
                            ),
                            selectedItem: workRequest.agseamCondition != null
                                ? EamConditionDto(condition: workRequest.agseamCondition)
                                : null,
                            items: (String searchTerm, props) async {
                              var response = await _workRequestDal.getConditionList(searchTerm);
                              var data = response.data?.map((e) => e).toList();
                              return data ?? [];
                            },
                            dropdownBuilder: (context, selectedItem) {
                              return Text(selectedItem?.condition ?? '', style: TextStyle(fontSize: 16));
                            },
                            decoratorProps: DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: 'Condition',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            onChanged: (value) {
                              value as EamConditionDto;
                              _conditionController.text = value.condition ?? '';
                            },
                          ),
                          const SizedBox(height: 8.0),
                          DropdownSearch<EamTaskDto>(
                            validator:(value) {
                              if (value == null) {
                                return 'Please select Task';
                              }
                              return null;
                            },
                            compareFn: (item, selectedItem) => item == selectedItem,
                            popupProps: PopupPropsMultiSelection.menu(
                              showSearchBox: true,
                              itemBuilder: (BuildContext context, EamTaskDto item, bool isDisabled, bool isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: !isSelected
                                      ? null
                                      : BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: ListTile(
                                      selected: isSelected,
                                      dense: true,
                                      title: Text(item.taskId ?? '', style: TextStyle(fontSize: 16)),
                                      contentPadding: const EdgeInsets.all(8),
                                      subtitle: Text(item.taskName ?? '')
                                  ),
                                );
                              },
                            ),
                            selectedItem: workRequest.agseamTaskID != null
                                ? EamTaskDto(taskId: workRequest.agseamTaskID)
                                : null,
                            items: (String searchTerm, props) async {
                              var response = await _workRequestDal.getTaskList(searchTerm);
                              var data = response.data?.map((e) => e).toList();
                              return data ?? [];
                            },
                            dropdownBuilder: (context, selectedItem) {
                              return Text(selectedItem?.taskId ?? '', style: TextStyle(fontSize: 16));
                            },
                            decoratorProps: DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: 'Task',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            onChanged: (value) {
                              value as EamTaskDto;
                              _taskIdController.text = value.taskId ?? '';
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Work Center ID',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  // if (Platform.isAndroid) {
                                  //   Environment.zebraMethodChannel.invokeMethod("toggleSoftScan");
                                  // }
                                  // barcode scanner
                                  final barcode = await Navigator.pushNamed(context, '/mobileScanner');
                                  if (barcode == null || barcode.toString().isEmpty) {
                                    return;
                                  }
                                  if (barcode != '-1') {
                                    _validateWrkCtrId(barcode.toString());
                                  }
                                },
                                icon: const Icon(Icons.qr_code_scanner_outlined))
                            ),
                            controller: _wrkCtrIdController,
                            // disable text input for Work Center ID
                            readOnly: true
                          ),
                        ],
                      ),
                    ),
                    // button to update work request
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          var updatedWorkRequest = workRequest.copyWith(
                            agseamCondition: _conditionController.text,
                            agseamTaskID: _taskIdController.text,
                            wrkCtrId: _wrkCtrIdController.text,
                          );
                          ref.read(workRequestProvider(widget._agseamWrId).notifier).updateWorkRequest(updatedWorkRequest);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Update Work Request',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: workRequest.workflowStatus == EamWorkflowStatus.accepted ? null : () {
                            ref.read(workRequestProvider(widget._agseamWrId).notifier).updateAcceptedWorkRequest(workRequest);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Accept',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: workRequest.workflowStatus == EamWorkflowStatus.accepted && validateCreateWorkOrder(workRequest) ? () {
                            var updatedWorkRequest = workRequest.copyWith(
                              agseamCondition: _conditionController.text,
                              agseamTaskID: _taskIdController.text,
                              wrkCtrId: _wrkCtrIdController.text,
                            );
                            ref.read(workRequestProvider(widget._agseamWrId).notifier).createWorkOrderTable(updatedWorkRequest);
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Create Work Order',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
