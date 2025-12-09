import "package:collection/collection.dart";
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/action_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationEntryHeader/operation_entry_header_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationEntryLine/operation_entry_line_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplate/operation_template_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';

class OperationEntryHeaderDetails extends ConsumerStatefulWidget {
  const OperationEntryHeaderDetails({super.key, required this.operationEntryHeaderId});

  final int operationEntryHeaderId;

  @override
  ConsumerState createState() => _OperationEntryHeaderDetailsState();
}

class _OperationEntryHeaderDetailsState extends ConsumerState<OperationEntryHeaderDetails> {
  late ActionType _actionType;
  late OperationEntryHeaderDto _operationEntryHeaderTemp;
  late NavigatorState _navigator;
  late int _operationEntryHeaderId;

  @override
  void initState() {
    super.initState();

    _operationEntryHeaderId = widget.operationEntryHeaderId;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    if (_operationEntryHeaderId == 0) {
      _actionType = ActionType.add;
    } else {
      _actionType = ActionType.view;
    }

    _operationEntryHeaderTemp = operationEntryHeaderOriginal();

    if (_actionType == ActionType.add) {
      _operationEntryHeaderTemp = _operationEntryHeaderTemp.copyWith(
        date: DateTime.now(),
      );
    }
  }

  OperationEntryHeaderDto operationEntryHeaderOriginal() {
    var asd = ref.read(operationEntryHeaderProvider).whenData((data) {
      return data.firstWhere((item) => item.operationEntryHeaderId == _operationEntryHeaderId);
    });

    return asd.valueOrNull ?? OperationEntryHeaderDto();
  }

  @override
  Widget build(BuildContext context) {
    var operationTemplates = ref.watch(operationTemplateProvider);
    // var operationEntryHeader = ref.watch(operationEntryHeaderProvider().select((state) =>
    //   state.valueOrNull?.firstWhere(
    //         (item) => item.operationEntryHeaderId == _operationEntryHeaderId,
    //     orElse: () => _operationEntryHeaderTemp,
    //   ) ?? _operationEntryHeaderTemp
    // ));
    var operationEntryHeader = ref.watch(operationEntryHeaderProvider.select((state) => state.whenData((data) => data.firstWhere((item) => item.operationEntryHeaderId == _operationEntryHeaderId, orElse: () => _operationEntryHeaderTemp))));

    // group by the operation template row id
    var operationEntryLines = ref.watch(operationEntryLineProvider(_operationEntryHeaderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Entry Header Details'),
        actions: [
          // switch between update and view modes
          switch (_actionType) {
            ActionType.update => IconButton(
              icon: const Icon(Icons.notes),
              onPressed: () async {
                setState(() {
                  _operationEntryHeaderTemp = operationEntryHeaderOriginal();
                  _actionType = ActionType.view;
                });
              },
              tooltip: 'View Operation Entry Header',
            ),
            ActionType.view => IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _actionType = ActionType.update;
                });
              },
              tooltip: 'Edit Operation Entry Header',
            ),
            ActionType.add => Icon(Icons.add_circle_outline),
          }
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(operationEntryHeaderProvider.notifier).getOperationEntryHeaderById(_operationEntryHeaderTemp.operationEntryHeaderId!);
          ref.invalidate(operationEntryLineProvider);
        },
        child: operationEntryHeader.when(
            data: (data) {
              return Column(
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
                              ActionType.add => 'Add Operation Entry Header',
                              ActionType.update => 'Update Operation Entry Header',
                              ActionType.view => 'View Operation Entry Header',
                            },
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            // conditionally set the initial value based on the action type
                            controller: TextEditingController(text: data.operationEntryHeaderNumber),
                            decoration: InputDecoration(
                                floatingLabelStyle: Environment.floatingLabelStyle,
                                labelText: 'Operation Entry Header Number',
                                border: const OutlineInputBorder()),
                            readOnly: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: operationTemplates.when(
                              data: (types) {
                                if (types.isEmpty) {
                                  return const Text('No operation types available');
                                }
                                return DropdownSearch<OperationTemplateDto>(
                                  validator:(value) {
                                    if (value == null) {
                                      return 'Please select operation type';
                                    }
                                    return null;
                                  },
                                  compareFn: (item, selectedItem) => item.operationTypeId == selectedItem.operationTypeId,
                                  popupProps: PopupPropsMultiSelection.menu(
                                    showSearchBox: true,
                                    itemBuilder: (BuildContext context, OperationTemplateDto operationTemplate, bool isDisabled, bool isSelected) {
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
                                            title: Text(operationTemplate.name ?? 'No Name', style: const TextStyle(fontSize: 16)),
                                            //contentPadding: const EdgeInsets.all(8),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(operationTemplate.description ?? 'No Description', style: const TextStyle(fontSize: 14)),
                                              ],
                                            )
                                        ),
                                      );
                                    },
                                  ),
                                  // black border with rounded corners
                                  decoratorProps: DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      labelText: 'Operation Template',
                                      floatingLabelStyle: Environment.floatingLabelStyle,
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
                                  selectedItem: types.firstWhere((item) {
                                    switch (_actionType) {
                                      case ActionType.add:
                                        return false; // No selection in add mode
                                      case ActionType.update:
                                        return item.operationTypeId == _operationEntryHeaderTemp.operationTemplateId;
                                      case ActionType.view:
                                        return item.operationTypeId == data.operationTemplateId;
                                    }
                                  },
                                    orElse: () => OperationTemplateDto(),
                                  ),
                                  enabled: _actionType == ActionType.add,
                                  dropdownBuilder: (context, selectedItem) {
                                    return Text(selectedItem?.name ?? '', style: TextStyle(fontSize: 16));
                                  },
                                  onChanged: (value) => setState(() => _operationEntryHeaderTemp = _operationEntryHeaderTemp.copyWith(operationTemplateId: value?.operationTypeId)),
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
                            // conditionally set the initial value based on the action type, if add mode, use current date
                            controller: TextEditingController(text: _actionType == ActionType.view ? DateFormat.yMMMMd().format(data.date!) : DateFormat.yMMMMd().format(DateTime.now())),
                            decoration: InputDecoration(
                              labelText: 'Date',
                              floatingLabelStyle: Environment.floatingLabelStyle,
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  if (_actionType != ActionType.view) {
                                    showDatePicker(
                                      context: context,
                                      initialDate: _operationEntryHeaderTemp.date ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        setState(() {
                                          _operationEntryHeaderTemp = _operationEntryHeaderTemp.copyWith(date: selectedDate);
                                        });
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                            onChanged: (value) => _operationEntryHeaderTemp = _operationEntryHeaderTemp.copyWith(date: DateTime.tryParse(value)),
                            readOnly: _actionType == ActionType.view,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: TextEditingController(text: _actionType == ActionType.view ? data.description : _operationEntryHeaderTemp.description),
                            decoration: InputDecoration(
                                floatingLabelStyle: Environment.floatingLabelStyle,
                                labelText: 'Description',
                                border: const OutlineInputBorder()
                            ),
                            onChanged: (value) => _operationEntryHeaderTemp = _operationEntryHeaderTemp.copyWith(description: value),
                            readOnly: _actionType == ActionType.view,
                          ),
                        ),
                        ListTile(
                            title: Text(_actionType == ActionType.view ? data.createdBy ?? 'N/A' : _operationEntryHeaderTemp.createdBy ?? 'N/A'),
                            subtitle: const Text('Created By'),
                            trailing: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 24)
                        ),
                        ListTile(
                            title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(data.createdDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm().format(_operationEntryHeaderTemp.createdDateTime ?? DateTime.now())),
                            subtitle: const Text('Created Date Time'),
                            trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor, size: 24)
                        ),
                        ListTile(
                            title: Text(_actionType == ActionType.view ? data.modifiedBy ?? 'N/A' : _operationEntryHeaderTemp.modifiedBy ?? 'N/A'),
                            subtitle: const Text('Modified By'),
                            trailing: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 24)
                        ),
                        ListTile(
                            title: Text(_actionType == ActionType.view ? DateFormat.yMMMMd().add_jm().format(data.modifiedDateTime ?? DateTime.now()) : DateFormat.yMMMMd().add_jm() .format(_operationEntryHeaderTemp.modifiedDateTime ?? DateTime.now())),
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
                                          title: Text('Add Operation Entry Header'),
                                          content: Text('Are you sure you want to add this Operation Entry Header?'),
                                          onConfirm: () async {
                                            try {
                                              _operationEntryHeaderTemp = await ref.read(operationEntryHeaderProvider.notifier).addOperationEntryHeader(_operationEntryHeaderTemp);
                                              _operationEntryHeaderId = _operationEntryHeaderTemp.operationTemplateId!;
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
                                          title: Text('Update Operation Entry Header'),
                                          content: Text('Are you sure you want to update this Operation Entry Header?'),
                                          onConfirm: () async {
                                            try {
                                              await ref.read(operationEntryHeaderProvider.notifier).updateOperationEntryHeader(_operationEntryHeaderTemp);
                                              _operationEntryHeaderTemp = operationEntryHeaderOriginal();
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
                                _actionType == ActionType.add ? 'Add Operation Entry Header' : 'Update Operation Entry Header',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                        if (_actionType == ActionType.update) ...[
                          // delete Operation Entry Header button
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmationDialog(
                                      title: const Text('Delete Operation Entry Header'),
                                      content: const Text('Are you sure you want to delete this Operation Entry Header?'),
                                      onConfirm: () async {
                                        try {
                                          await ref.read(operationEntryHeaderProvider.notifier).deleteOperationEntryHeader(data.operationEntryHeaderId!);
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
                                'Delete Operation Entry Header',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                        if (_actionType == ActionType.view) ...[
                          Container(
                            color: Colors.grey[200],
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Rows', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          operationEntryLines.when(
                            data: (rows) {
                              if (rows.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('No operation entry lines available'),
                                );
                              }

                              // group by operationTemplateRowId and take the first row for each group
                              // this is to avoid showing duplicate rows for the same operationTemplateRowId
                              var groupedRows = groupBy(rows, (OperationEntryLineDto row) => row.operationTemplateRowId)
                                  .entries
                                  .map((entry) => entry.value.first)
                                  .toList();

                              return ListView.separated(
                                separatorBuilder: (context, index) => const Divider(),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: groupedRows.length,
                                itemBuilder: (context, index) {
                                  var row = groupedRows[index];
                                  return ListTile(
                                    minTileHeight: 70,
                                    title: Text(row.operationTemplateRow?.rowLabel ?? 'No Description'),
                                    // chevron icon to indicate more details
                                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                                    onTap: () {
                                      _navigator.pushNamed(
                                        '/operationEntryLineDetails',
                                        arguments: {
                                          'operationEntryHeaderId': _operationEntryHeaderId,
                                          'operationTemplateRowId': row.operationTemplateRowId,
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            error: (error, stackTrace) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Error loading Operation Entry Header rows: $error'),
                            ),
                            loading: () => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: LinearProgressIndicator(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error loading Operation Entry Header: $error'),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            )
        )
      ),
    );
  }
}
