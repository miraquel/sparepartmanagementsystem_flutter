import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/action_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/operation_template_data_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_column_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplateColumn/operation_template_column_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';

class OperationTemplateColumnDetails extends ConsumerStatefulWidget {
  const OperationTemplateColumnDetails({super.key, required this.operationTemplateColumnId, this.operationTemplateId});

  final int operationTemplateColumnId;
  final int? operationTemplateId;

  @override
  ConsumerState createState() => _OperationTemplateColumnDetailsState();
}

class _OperationTemplateColumnDetailsState extends ConsumerState<OperationTemplateColumnDetails> {
  late ActionType _actionType;
  late OperationTemplateColumnDto _operationTemplateColumnTemp;
  late NavigatorState _navigator;
  late int _operationTemplateColumnId;
  late int _operationTemplateId;

  @override
  void initState() {
    super.initState();

    _operationTemplateColumnId = widget.operationTemplateColumnId;
    _operationTemplateId = widget.operationTemplateId ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    if (_operationTemplateColumnId == 0) {
      _actionType = ActionType.add;
    } else {
      _actionType = ActionType.view;
    }

    _operationTemplateColumnTemp = operationTemplateColumnOriginal();

    if (_actionType == ActionType.add) {
      _operationTemplateColumnTemp = _operationTemplateColumnTemp.copyWith(
        operationTemplateId: _operationTemplateId,
        position: 0,
        dataType: OperationTemplateDataType.string,
      );
    }
  }

  OperationTemplateColumnDto operationTemplateColumnOriginal() {
    return ref.read(operationTemplateColumnProvider(_operationTemplateId)).valueOrNull?.firstWhere(
          (item) => item.operationTemplateColumnId == _operationTemplateColumnId,
      orElse: () => OperationTemplateColumnDto(),
    ) ?? OperationTemplateColumnDto();
  }

  @override
  Widget build(BuildContext context) {
    var operationTemplateColumn = ref.watch(operationTemplateColumnProvider(_operationTemplateId).select((state) =>
    state.valueOrNull?.firstWhere(
          (item) => item.operationTemplateColumnId == _operationTemplateColumnId,
      orElse: () => _operationTemplateColumnTemp,
    ) ?? _operationTemplateColumnTemp
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Template Column Details'),
        actions: [
          // switch between update and view modes
          switch (_actionType) {
            ActionType.update => IconButton(
              icon: const Icon(Icons.notes),
              onPressed: () async {
                setState(() {
                  _actionType = ActionType.view;
                  _operationTemplateColumnTemp = operationTemplateColumnOriginal();
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
        onRefresh: () async => ref.read(operationTemplateColumnProvider(_operationTemplateId).notifier).getOperationTemplateColumnById(_operationTemplateColumnTemp.operationTemplateColumnId!),
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
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplateColumn.columnLabel : _operationTemplateColumnTemp.columnLabel),
                      decoration: const InputDecoration(labelText: 'Column Label', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateColumnTemp = _operationTemplateColumnTemp.copyWith(columnLabel: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // DataType dropdown
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      value: _actionType == ActionType.view ? operationTemplateColumn.dataType.toString() : _operationTemplateColumnTemp.dataType.toString(),
                      decoration: const InputDecoration(labelText: 'Data Type', border: OutlineInputBorder()),
                        items: OperationTemplateDataType.values.map((dataType) {
                        return DropdownMenuItem<String>(
                          value: dataType.toString(),
                          child: Text(dataType.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: _actionType == ActionType.view ? null : (value) {
                        if (value != null) {
                          _operationTemplateColumnTemp = _operationTemplateColumnTemp.copyWith(dataType: OperationTemplateDataType.values.firstWhere((e) => e.toString() == value));
                        }
                      },
                    ),
                  ),
                  // Position
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplateColumn.position?.toString() : _operationTemplateColumnTemp.position?.toString()),
                      decoration: const InputDecoration(labelText: 'Position', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => _operationTemplateColumnTemp = _operationTemplateColumnTemp.copyWith(position: int.tryParse(value)),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // effective date with date picker, formatted as dd/MM/yyyy
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationTemplateColumn.createdBy ?? 'N/A' : _operationTemplateColumnTemp.createdBy ?? 'N/A'),
                      subtitle: const Text('Created By'),
                      trailing: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplateColumn.createdDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm().format(_operationTemplateColumnTemp.createdDateTime ?? DateTime.now())),
                      subtitle: const Text('Created Date Time'),
                      trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationTemplateColumn.modifiedBy ?? 'N/A' : _operationTemplateColumnTemp.modifiedBy ?? 'N/A'),
                      subtitle: const Text('Modified By'),
                      trailing: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplateColumn.modifiedDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm() .format(_operationTemplateColumnTemp.modifiedDateTime ?? DateTime.now())),
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
                                    title: Text('Add Operation Template Column'),
                                    content: Text('Are you sure you want to add this operation template column?'),
                                    onConfirm: () async {
                                      try {
                                        _operationTemplateColumnTemp = await ref.read(operationTemplateColumnProvider(_operationTemplateId).notifier).addOperationTemplateColumn(_operationTemplateColumnTemp);
                                        _operationTemplateColumnId = _operationTemplateColumnTemp.operationTemplateColumnId!;
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
                                    title: Text('Update Operation Template Column'),
                                    content: Text('Are you sure you want to update this operation template Column?'),
                                    onConfirm: () async {
                                      try {
                                        await ref.read(operationTemplateColumnProvider(_operationTemplateId).notifier).updateOperationTemplateColumn(_operationTemplateColumnTemp);
                                        _operationTemplateColumnTemp = operationTemplateColumnOriginal();
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
                          _actionType == ActionType.add ? 'Add Operation Template Column' : 'Update Operation Template Column',
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
                                title: const Text('Delete Operation Template Column'),
                                content: const Text('Are you sure you want to delete this operation template Column?'),
                                onConfirm: () async {
                                  try {
                                    await ref.read(operationTemplateColumnProvider(_operationTemplateId).notifier).deleteOperationTemplateColumn(operationTemplateColumn.operationTemplateColumnId!);
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
                          'Delete Operation Template Column',
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
