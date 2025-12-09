import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/action_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplate/operation_template_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationType/operation_type_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';

class OperationTemplateDetails extends ConsumerStatefulWidget {
  const OperationTemplateDetails({super.key, required this.operationTemplateId});

  final int? operationTemplateId;

  @override
  ConsumerState<OperationTemplateDetails> createState() => _OperationTemplateDetailsState();
}

class _OperationTemplateDetailsState extends ConsumerState<OperationTemplateDetails> {
  late ActionType _actionType;
  late OperationTemplateDto _operationTemplateTemp;
  late NavigatorState _navigator;
  late int _operationTemplateId;
  final QuillController _quillController = QuillController.basic();

  @override
  void initState() {
    super.initState();

    _operationTemplateId = widget.operationTemplateId ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    if (_operationTemplateId == 0) {
      _actionType = ActionType.add;
    } else {
      _actionType = ActionType.view;
    }

    _operationTemplateTemp = operationTemplateOriginal();

    if (_actionType == ActionType.add) {
      _operationTemplateTemp = _operationTemplateTemp.copyWith(
        effectiveDate: DateTime.now(),
      );
    }
  }

  OperationTemplateDto operationTemplateOriginal() {
    return ref.read(operationTemplateProvider).valueOrNull?.firstWhere(
      (item) => item.operationTemplateId == _operationTemplateId,
      orElse: () => OperationTemplateDto(),
    ) ?? OperationTemplateDto();
  }

  @override
  Widget build(BuildContext context) {
    var operationTemplate = ref.watch(operationTemplateProvider.select((state) =>
      state.valueOrNull?.firstWhere(
            (item) => item.operationTemplateId == _operationTemplateId,
        orElse: () => _operationTemplateTemp,
      ) ?? _operationTemplateTemp
    ));

    _quillController.document = Document.fromJson(
      jsonDecode(_actionType == ActionType.view ? (operationTemplate.description ?? '[{"insert":"\\n"}]') : _operationTemplateTemp.description ?? '[{"insert":"\\n"}]')
    );
    _quillController.readOnly = _actionType == ActionType.view;
    var operationTypes = ref.watch(operationTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Template Details'),
        actions: [
          // switch between update and view modes
          switch (_actionType) {
            ActionType.update => IconButton(
              icon: const Icon(Icons.notes),
              onPressed: () async {
                setState(() {
                  _actionType = ActionType.view;
                  _operationTemplateTemp = operationTemplateOriginal();
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
        onRefresh: () async => ref.read(operationTemplateProvider.notifier).getOperationTemplateById(_operationTemplateTemp.operationTemplateId!),
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
                    child: operationTypes.when(
                      data: (types) {
                        if (types.isEmpty) {
                          return const Text('No operation types available');
                        }
                        return DropdownSearch<OperationTypeDto>(
                          validator:(value) {
                            if (value == null) {
                              return 'Please select operation type';
                            }
                            return null;
                          },
                          compareFn: (item, selectedItem) => item.operationTypeId == selectedItem.operationTypeId,
                          popupProps: PopupPropsMultiSelection.menu(
                            showSearchBox: true,
                            itemBuilder: (BuildContext context, OperationTypeDto operationType, bool isDisabled, bool isSelected) {
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
                                  // make the text size the same as the default text size
                                  title: Text(operationType.name ?? 'No Name', style: const TextStyle(fontSize: 16)),
                                  //contentPadding: const EdgeInsets.all(8),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(operationType.description ?? 'No Description', style: const TextStyle(fontSize: 14)),
                                    ],
                                  )
                                ),
                              );
                            },
                          ),
                          // black border with rounded corners
                          decoratorProps: DropDownDecoratorProps(
                            decoration: InputDecoration(
                              labelText: 'Operation Type',
                              border: OutlineInputBorder(),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              suffixIconColor: Theme.of(context).primaryColor,
                              labelStyle: TextStyle(
                                color: _actionType == ActionType.view ? Colors.black : Theme.of(context).primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          items: (String searchTerm, props) async {
                            return types.where((item) => item.name?.toLowerCase().contains(searchTerm.toLowerCase()) ?? false).toList();
                          },
                          selectedItem: types.firstWhere(
                            (item) {
                              switch (_actionType) {
                                case ActionType.add:
                                  return false; // No selection in add mode
                                case ActionType.update:
                                  return item.operationTypeId == _operationTemplateTemp.operationTypeId;
                                case ActionType.view:
                                  return item.operationTypeId == operationTemplate.operationTypeId;
                              }
                            },
                            orElse: () => OperationTypeDto(),
                          ),
                          enabled: _actionType != ActionType.view,
                          dropdownBuilder: (context, selectedItem) {
                            return Text(selectedItem?.name ?? '', style: TextStyle(fontSize: 16));
                          },
                          onChanged: (value) {
                            value as OperationTypeDto;
                            setState(() => _operationTemplateTemp = _operationTemplateTemp.copyWith(operationTypeId: value.operationTypeId));
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                        );
                      },
                      error: (error, stackTrace) => Text('Error loading operation types: $error'),
                      loading: () => Padding(padding: const EdgeInsets.symmetric(vertical: 16.0), child: const LinearProgressIndicator())
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // conditionally set the initial value based on the action type
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplate.name : _operationTemplateTemp.name),
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateTemp = _operationTemplateTemp.copyWith(name: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Divider(thickness: 1, height: 1),
                  ),
                  // Quill editor for description
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: _actionType == ActionType.view ? Colors.black : Theme.of(context).primaryColor),
                    ),
                  ),
                  QuillSimpleToolbar(
                    controller: _quillController,
                    config: const QuillSimpleToolbarConfig(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillEditor.basic(
                      controller: _quillController,
                      config: const QuillEditorConfig(),
                    ),
                  ),
                  // separator
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Divider(thickness: 1, height: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplate.documentNo : _operationTemplateTemp.documentNo),
                      decoration: const InputDecoration(labelText: 'Document No.', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateTemp = _operationTemplateTemp.copyWith(documentNo: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // revision
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: _actionType == ActionType.view ? operationTemplate.revision : _operationTemplateTemp.revision),
                      decoration: const InputDecoration(labelText: 'Revision', border: OutlineInputBorder()),
                      onChanged: (value) => _operationTemplateTemp = _operationTemplateTemp.copyWith(revision: value),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  // effective date with date picker, formatted as dd/MM/yyyy
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: _actionType == ActionType.view ? DateFormat.yMMMMd().format(operationTemplate.effectiveDate ?? DateTime.now()) : DateFormat.yMMMMd().format(_operationTemplateTemp.effectiveDate ?? DateTime.now())),
                      decoration: InputDecoration(
                        labelText: 'Effective Date',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: _actionType == ActionType.view ? null : () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: _operationTemplateTemp.effectiveDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (selectedDate != null) {
                              setState(() => _operationTemplateTemp = _operationTemplateTemp.copyWith(effectiveDate: selectedDate));
                            }
                          },
                        ),
                      ),
                      readOnly: _actionType == ActionType.view,
                    ),
                  ),
                  ListTile(
                    title: Text(_actionType == ActionType.view ? operationTemplate.createdBy ?? 'N/A' : _operationTemplateTemp.createdBy ?? 'N/A'),
                    subtitle: const Text('Created By'),
                    trailing: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                    title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplate.createdDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm().format(_operationTemplateTemp.createdDateTime ?? DateTime.now())),
                    subtitle: const Text('Created Date Time'),
                    trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                    title: Text(_actionType == ActionType.view ? operationTemplate.modifiedBy ?? 'N/A' : _operationTemplateTemp.modifiedBy ?? 'N/A'),
                    subtitle: const Text('Modified By'),
                    trailing: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 24)
                  ),
                  ListTile(
                    title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(operationTemplate.modifiedDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm() .format(_operationTemplateTemp.modifiedDateTime ?? DateTime.now())),
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
                                        _operationTemplateTemp = _operationTemplateTemp.copyWith(
                                          description: jsonEncode(_quillController.document.toDelta().toJson())
                                        );
                                        _operationTemplateTemp = await ref.read(operationTemplateProvider.notifier).addOperationTemplate(_operationTemplateTemp);
                                        _operationTemplateId = _operationTemplateTemp.operationTemplateId!;
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
                                    title: Text('Update Operation Template'),
                                    content: Text('Are you sure you want to update this operation template?'),
                                    onConfirm: () async {
                                      try {
                                        _operationTemplateTemp = _operationTemplateTemp.copyWith(
                                          description: jsonEncode(_quillController.document.toDelta().toJson())
                                        );
                                        await ref.read(operationTemplateProvider.notifier).updateOperationTemplate(_operationTemplateTemp);
                                        _operationTemplateTemp = operationTemplateOriginal();
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
                          _actionType == ActionType.add ? 'Add Operation Template' : 'Update Operation Template',
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
                                    await ref.read(operationTemplateProvider.notifier).deleteOperationTemplate(operationTemplate.operationTemplateId!);
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
                  ],
                  if (_actionType == ActionType.view) ...[
                    Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Setup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    // button to navigate to the list of operation template rows
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _navigator.pushNamed('/operationTemplateRowList', arguments: _operationTemplateId);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Operation Template Rows',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // button to navigate to the list of operation template columns
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _navigator.pushNamed('/operationTemplateColumnList', arguments: _operationTemplateId);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Operation Template Columns',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // button to navigate to the list of operation template verificators
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _navigator.pushNamed('/operationTemplateVerificatorList', arguments: _operationTemplateId);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Operation Template Verificators',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
