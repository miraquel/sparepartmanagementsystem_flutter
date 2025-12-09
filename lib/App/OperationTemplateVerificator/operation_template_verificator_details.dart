import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/action_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_verificator_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplateVerificator/operation_template_verificator_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';

class OperationTemplateVerificatorDetails extends ConsumerStatefulWidget {
  const OperationTemplateVerificatorDetails({super.key, required this.operationTemplateVerificatorId, this.operationTemplateId});

  final int operationTemplateVerificatorId;
  final int? operationTemplateId;

  @override
  ConsumerState createState() => _OperationTemplateVerificatorDetailsState();
}

class _OperationTemplateVerificatorDetailsState extends ConsumerState<OperationTemplateVerificatorDetails> {
  late ActionType _actionType;
  late OperationTemplateVerificatorDto _operationTemplateVerificatorTemp;
  late NavigatorState _navigator;
  late int _operationTemplateVerificatorId;
  late int _operationTemplateId;

  @override
  void initState() {
    super.initState();

    _operationTemplateVerificatorId = widget.operationTemplateVerificatorId;
    _operationTemplateId = widget.operationTemplateId ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    if (_operationTemplateVerificatorId == 0) {
      _actionType = ActionType.add;
    } else {
      _actionType = ActionType.view;
    }

    _operationTemplateVerificatorTemp = operationTemplateVerificatorOriginal();

    if (_actionType == ActionType.add) {
      _operationTemplateVerificatorTemp = _operationTemplateVerificatorTemp.copyWith(
        operationTemplateId: _operationTemplateId
      );
    }
  }

  OperationTemplateVerificatorDto operationTemplateVerificatorOriginal() {
    return ref.read(operationTemplateVerificatorProvider(_operationTemplateId)).valueOrNull?.firstWhere(
          (item) => item.operationTemplateVerificatorId == _operationTemplateVerificatorId,
      orElse: () => OperationTemplateVerificatorDto(),
    ) ?? OperationTemplateVerificatorDto();
  }

  @override
  Widget build(BuildContext context) {
    var operationTemplateVerificator = ref.watch(operationTemplateVerificatorProvider(_operationTemplateId).select((state) =>
      state.valueOrNull?.firstWhere(
            (item) => item.operationTemplateVerificatorId == _operationTemplateVerificatorId,
        orElse: () => _operationTemplateVerificatorTemp,
      ) ?? _operationTemplateVerificatorTemp
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Template Verificator Details'),
        actions: [
          // switch between update and view modes
          switch (_actionType) {
            ActionType.update => IconButton(
              icon: const Icon(Icons.notes),
              onPressed: () async {
                setState(() {
                  _actionType = ActionType.view;
                  _operationTemplateVerificatorTemp = operationTemplateVerificatorOriginal();
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
        onRefresh: () async => ref.read(operationTemplateVerificatorProvider(_operationTemplateId).notifier).getOperationTemplateVerificatorById(_operationTemplateVerificatorTemp.operationTemplateVerificatorId!),
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
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplateVerificator.name : _operationTemplateVerificatorTemp.name),
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateVerificatorTemp = _operationTemplateVerificatorTemp.copyWith(name: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // Position
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplateVerificator.jobPosition : _operationTemplateVerificatorTemp.jobPosition),
                      decoration: const InputDecoration(labelText: 'Job Position', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateVerificatorTemp = _operationTemplateVerificatorTemp.copyWith(jobPosition: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // Label
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplateVerificator.label : _operationTemplateVerificatorTemp.label),
                      decoration: const InputDecoration(labelText: 'Label', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateVerificatorTemp = _operationTemplateVerificatorTemp.copyWith(label: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // effective date with date picker, formatted as dd/MM/yyyy
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationTemplateVerificator.createdBy ?? 'N/A' : _operationTemplateVerificatorTemp.createdBy ?? 'N/A'),
                      subtitle: const Text('Created By'),
                      trailing: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplateVerificator.createdDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm().format(_operationTemplateVerificatorTemp.createdDateTime ?? DateTime.now())),
                      subtitle: const Text('Created Date Time'),
                      trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? operationTemplateVerificator.modifiedBy ?? 'N/A' : _operationTemplateVerificatorTemp.modifiedBy ?? 'N/A'),
                      subtitle: const Text('Modified By'),
                      trailing: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                      title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplateVerificator.modifiedDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm() .format(_operationTemplateVerificatorTemp.modifiedDateTime ?? DateTime.now())),
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
                                    title: Text('Add Operation Template'),
                                    content: Text('Are you sure you want to add this operation template?'),
                                    onConfirm: () async {
                                      try {
                                        _operationTemplateVerificatorTemp = await ref.read(operationTemplateVerificatorProvider(_operationTemplateId).notifier).addOperationTemplateVerificator(_operationTemplateVerificatorTemp);
                                        _operationTemplateVerificatorId = _operationTemplateVerificatorTemp.operationTemplateVerificatorId!;
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
                                    title: Text('Update Operation Template Verificator'),
                                    content: Text('Are you sure you want to update this operation template Verificator?'),
                                    onConfirm: () async {
                                      try {
                                        await ref.read(operationTemplateVerificatorProvider(_operationTemplateId).notifier).updateOperationTemplateVerificator(_operationTemplateVerificatorTemp);
                                        _operationTemplateVerificatorTemp = operationTemplateVerificatorOriginal();
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
                          _actionType == ActionType.add ? 'Add Operation Template Verificator' : 'Update Operation Template Verificator',
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
                                title: const Text('Delete Operation Template Verificator'),
                                content: const Text('Are you sure you want to delete this operation template Verificator?'),
                                onConfirm: () async {
                                  try {
                                    await ref.read(operationTemplateVerificatorProvider(_operationTemplateId).notifier).deleteOperationTemplateVerificator(operationTemplateVerificator.operationTemplateVerificatorId!);
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
                          'Delete Operation Template Verificator',
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
