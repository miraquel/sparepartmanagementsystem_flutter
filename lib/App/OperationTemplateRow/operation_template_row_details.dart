import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/action_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_row_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplateRow/operation_template_row_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';

class OperationTemplateRowDetails extends ConsumerStatefulWidget {
  const OperationTemplateRowDetails({super.key, this.operationTemplateId, required this.operationTemplateRowId});

  final int operationTemplateRowId;
  final int? operationTemplateId;

  @override
  ConsumerState<OperationTemplateRowDetails> createState() => _OperationTemplateDetailsState();
}

class _OperationTemplateDetailsState extends ConsumerState<OperationTemplateRowDetails> {
  late ActionType _actionType;
  late OperationTemplateRowDto _operationTemplateRowTemp;
  late NavigatorState _navigator;
  late int _operationTemplateRowId;
  late int _operationTemplateId;

  @override
  void initState() {
    super.initState();

    _operationTemplateRowId = widget.operationTemplateRowId;
    _operationTemplateId = widget.operationTemplateId ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    if (_operationTemplateRowId == 0) {
      _actionType = ActionType.add;
    } else {
      _actionType = ActionType.view;
    }

    _operationTemplateRowTemp = operationTemplateRowOriginal();

    if (_actionType == ActionType.add) {
      _operationTemplateRowTemp = _operationTemplateRowTemp.copyWith(
          operationTemplateId: _operationTemplateId,
          position: 0,
      );
    }
  }

  OperationTemplateRowDto operationTemplateRowOriginal() {
    return ref.read(OperationTemplateRowProvider(_operationTemplateId)).valueOrNull?.firstWhere(
          (item) => item.operationTemplateRowId == _operationTemplateRowId,
      orElse: () => OperationTemplateRowDto(),
    ) ?? OperationTemplateRowDto();
  }

  @override
  Widget build(BuildContext context) {
    var operationTemplateRow = ref.watch(operationTemplateRowProvider(_operationTemplateId).select((state) =>
      state.valueOrNull?.firstWhere(
            (item) => item.operationTemplateRowId == _operationTemplateRowId,
        orElse: () => _operationTemplateRowTemp,
      ) ?? _operationTemplateRowTemp
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Template Row Details'),
        actions: [
          // switch between update and view modes
          switch (_actionType) {
            ActionType.update => IconButton(
              icon: const Icon(Icons.notes),
              onPressed: () async {
                setState(() {
                  _actionType = ActionType.view;
                  _operationTemplateRowTemp = operationTemplateRowOriginal();
                });
              },
              tooltip: 'View Operation Template',
            ),
            ActionType.view => IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _actionType = ActionType.update;
                });
              },
              tooltip: 'Edit Operation Template',
            ),
            ActionType.add => Icon(Icons.add_circle_outline),
          }
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(operationTemplateRowProvider(_operationTemplateId).notifier).getOperationTemplateRowById(_operationTemplateRowTemp.operationTemplateRowId!),
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
                        ActionType.add => 'Add Operation Template',
                        ActionType.update => 'Update Operation Template',
                        ActionType.view => 'View Operation Template',
                      },
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // conditionally set the initial value based on the action type
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplateRow.rowLabel : _operationTemplateRowTemp.rowLabel),
                      decoration: const InputDecoration(labelText: 'Row Label', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateRowTemp = _operationTemplateRowTemp.copyWith(rowLabel: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // Position
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplateRow.position?.toString() : _operationTemplateRowTemp.position?.toString()),
                      decoration: const InputDecoration(labelText: 'Position', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => _operationTemplateRowTemp = _operationTemplateRowTemp.copyWith(position: int.tryParse(value)),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // effective date with date picker, formatted as dd/MM/yyyy
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationTemplateRow.createdBy ?? 'N/A' : _operationTemplateRowTemp.createdBy ?? 'N/A'),
                      subtitle: const Text('Created By'),
                      trailing: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplateRow.createdDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm().format(_operationTemplateRowTemp.createdDateTime ?? DateTime.now())),
                      subtitle: const Text('Created Date Time'),
                      trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationTemplateRow.modifiedBy ?? 'N/A' : _operationTemplateRowTemp.modifiedBy ?? 'N/A'),
                      subtitle: const Text('Modified By'),
                      trailing: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplateRow.modifiedDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm() .format(_operationTemplateRowTemp.modifiedDateTime ?? DateTime.now())),
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
                                    title: Text('Add Operation Template Row'),
                                    content: Text('Are you sure you want to add this operation template row?'),
                                    onConfirm: () async {
                                      try {
                                        _operationTemplateRowTemp = await ref.read(operationTemplateRowProvider(_operationTemplateId).notifier).addOperationTemplateRow(_operationTemplateRowTemp);
                                        _operationTemplateRowId = _operationTemplateRowTemp.operationTemplateRowId!;
                                        setState(() => _actionType = ActionType.view);
                                      }
                                      on DioException catch (e) {
                                        var data = ApiResponseDto.fromJson(e.response?.data as Map<String, dynamic>);
                                        ref.read(snackbarMessageProvider.notifier).show(data.errorMessages.isNotEmpty ? data.errorMessages.first : (e.message ?? 'An error occurred'));
                                      }
                                    },
                                  );
                                },
                              );
                              break;
                            case ActionType.update:
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmationDialog(
                                    title: Text('Update Operation Template Row'),
                                    content: Text('Are you sure you want to update this operation template Row?'),
                                    onConfirm: () async {
                                      try {
                                        await ref.read(operationTemplateRowProvider(_operationTemplateId).notifier).updateOperationTemplateRow(_operationTemplateRowTemp);
                                        _operationTemplateRowTemp = operationTemplateRowOriginal();
                                        setState(() => _actionType = ActionType.view);
                                      }
                                      on DioException catch (e) {
                                        var data = ApiResponseDto.fromJson(e.response?.data as Map<String, dynamic>);
                                        ref.read(snackbarMessageProvider.notifier).show(data.errorMessages.isNotEmpty ? data.errorMessages.first : (e.message ?? 'An error occurred'));
                                      }
                                    },
                                  );
                                },
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
                          _actionType == ActionType.add ? 'Add Operation Template Row' : 'Update Operation Template Row',
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
                                title: const Text('Delete Operation Template Row'),
                                content: const Text('Are you sure you want to delete this operation template Row?'),
                                onConfirm: () async {
                                  try {
                                    await ref.read(operationTemplateRowProvider(_operationTemplateId).notifier).deleteOperationTemplateRow(operationTemplateRow.operationTemplateRowId!);
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
                          'Delete Operation Template Row',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
