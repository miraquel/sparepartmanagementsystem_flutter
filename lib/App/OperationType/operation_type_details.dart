import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/action_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationType/operation_type_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';

class OperationTypeDetails extends ConsumerStatefulWidget {
  const OperationTypeDetails({super.key, required this.operationTypeId});

  final int? operationTypeId;

  @override
  ConsumerState<OperationTypeDetails> createState() => _OperationTypeDetailsState();
}

class _OperationTypeDetailsState extends ConsumerState<OperationTypeDetails> {
  late ActionType _actionType;
  late OperationTypeDto _operationTypeTemp;
  late NavigatorState _navigator;
  late int _operationTypeId;

  @override
  void initState() {
    super.initState();

    _operationTypeId = widget.operationTypeId ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    if (widget.operationTypeId == 0) {
      _actionType = ActionType.add;
    } else {
      _actionType = ActionType.view;
    }

    _operationTypeTemp = operationTypeOriginal();
  }

  OperationTypeDto operationTypeOriginal() {
    return ref.read(operationTypeProvider).valueOrNull?.firstWhere(
          (item) => item.operationTypeId == _operationTypeId,
      orElse: () => OperationTypeDto(),
    ) ?? OperationTypeDto();
  }

  @override
  Widget build(BuildContext context) {
    var operationType = ref.watch(operationTypeProvider.select((state) =>
      state.valueOrNull?.firstWhere(
            (item) => item.operationTypeId == _operationTypeId,
        orElse: () => _operationTypeTemp,
      ) ?? _operationTypeTemp
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Type Details'),
        actions: [
          // switch between update and view modes
          switch (_actionType) {
            ActionType.update => IconButton(
              icon: const Icon(Icons.notes),
              onPressed: () async {
                setState(() {
                  _actionType = ActionType.view;
                  _operationTypeTemp = operationTypeOriginal();
                });
              },
              tooltip: 'View Operation Type',
            ),
            ActionType.view => IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _actionType = ActionType.update;
                });
              },
              tooltip: 'Edit Operation Type',
            ),
            ActionType.add => Icon(Icons.add_circle_outline),
          }
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(operationTypeProvider.notifier).getOperationTypeById(operationType.operationTypeId!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      switch (_actionType) {
                        ActionType.add => 'Add Operation Type',
                        ActionType.update => 'Update Operation Type',
                        ActionType.view => 'View Operation Type',
                      },
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // conditionally set the initial value based on the action type
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationType.name : _operationTypeTemp.name),
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                      onChanged: (value) => operationType = operationType.copyWith(name: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // conditionally set the initial value based on the action type
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationType.description : _operationTypeTemp.description),
                      decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                      onChanged: (value) => operationType = operationType.copyWith(description: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationType.createdBy ?? 'N/A' : _operationTypeTemp.createdBy ?? 'N/A'),
                      subtitle: const Text('Created By'),
                      trailing: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationType.createdDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm().format(_operationTypeTemp.createdDateTime ?? DateTime.now())),
                      subtitle: const Text('Created Date Time'),
                      trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationType.modifiedBy ?? 'N/A' : _operationTypeTemp.modifiedBy ?? 'N/A'),
                      subtitle: const Text('Modified By'),
                      trailing: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationType.modifiedDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm() .format(_operationTypeTemp.modifiedDateTime ?? DateTime.now())),
                      subtitle: const Text('Modified Date Time'),
                      trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  if (_actionType != ActionType.view) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          switch (_actionType) {
                            case ActionType.add:
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmationDialog(
                                    title: Text('Add Operation Type'),
                                    content: Text('Are you sure you want to add this operation type?'),
                                    onConfirm: () async {
                                      try {
                                        operationType = await ref.read(operationTypeProvider.notifier).addOperationType(operationType);
                                        _operationTypeId = operationType.operationTypeId!;
                                        setState(() => _actionType = ActionType.view);
                                      }
                                      on DioException catch (e) {
                                        var data = ApiResponseDto.fromJson(e.response?.data as Map<String, dynamic>);
                                        ref.read(snackbarMessageProvider.notifier).show(data.errorMessages.isNotEmpty ? data.errorMessages.first : (e.message ?? 'An error occurred'));
                                      }
                                    },
                                  );
                                }
                              );
                              break;
                            case ActionType.update:
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmationDialog(
                                    title: Text('Update Operation Type'),
                                    content: Text('Are you sure you want to update this operation type?'),
                                    onConfirm: () async {
                                      try {
                                        await ref.read(operationTypeProvider.notifier).updateOperationType(operationType);
                                        setState(() => _actionType = ActionType.view);
                                      }
                                      on DioException catch (e) {
                                        var data = ApiResponseDto.fromJson(e.response?.data as Map<String, dynamic>);
                                        ref.read(snackbarMessageProvider.notifier).show(data.errorMessages.isNotEmpty ? data.errorMessages.first : (e.message ?? 'An error occurred'));
                                      }
                                    },
                                  );
                                }
                              );
                              break;
                            case ActionType.view:
                            // Do nothing for view
                              break;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _actionType == ActionType.add ? 'Add Operation Type' : 'Update Operation Type',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  if (_actionType == ActionType.update) ...[
                    // delete operation template button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmationDialog(
                                title: const Text('Delete Operation Template'),
                                content: const Text('Are you sure you want to delete this operation template?'),
                                onConfirm: () async {
                                  try {
                                    await ref.read(operationTypeProvider.notifier).deleteOperationType(operationType.operationTypeId!);
                                    _navigator.pop();
                                  }
                                  on DioException catch (e) {
                                    var data = ApiResponseDto.fromJson(e.response?.data as Map<String, dynamic>);
                                    ref.read(snackbarMessageProvider.notifier).show(data.errorMessages.isNotEmpty ? data.errorMessages.first : (e.message ?? 'An error occurred'));
                                  }
                                },
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Delete Operation Template',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
