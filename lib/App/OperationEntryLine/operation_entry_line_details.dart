import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/operation_template_data_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationEntryLine/operation_entry_line_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';

class OperationEntryLineDetails extends ConsumerStatefulWidget {
  const OperationEntryLineDetails({
    super.key,
    required this.operationEntryHeaderId,
    required this.operationTemplateRowId,
  });

  final int operationEntryHeaderId;
  final int operationTemplateRowId;

  @override
  ConsumerState createState() => _OperationEntryLineDetailsState();
}

class _OperationEntryLineDetailsState extends ConsumerState<OperationEntryLineDetails> {
  late List<OperationEntryLineDto> _operationEntryLineTemp;
  late final int _operationEntryHeaderId = widget.operationEntryHeaderId;
  late final int _operationTemplateRowId = widget.operationTemplateRowId;
  late final String _operationTemplateRowLabel;

  @override
  void initState() {
    super.initState();

    // Initialize the temporary list with the original data
    _refreshOperationEntryLines();
    _operationTemplateRowLabel = _operationEntryLineTemp.isNotEmpty
        ? _operationEntryLineTemp.first.operationTemplateRow?.rowLabel ?? 'Unknown Row'
        : 'Unknown Row';
  }

  AsyncValue<List<OperationEntryLineDto>> get operationEntryLines {
    return ref.read(operationEntryLineProvider(_operationEntryHeaderId).select((state) {
      // select the operation entry lines by operation template row id
      return state.whenData((lines) => lines.where((line) => line.operationTemplateRowId == _operationTemplateRowId).toList());
    }));
  }

  Future<void> _refreshOperationEntryLines() async {
    // Refresh the operation entry lines
    _operationEntryLineTemp = operationEntryLines.valueOrNull ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$_operationTemplateRowLabel Row')),
      body: RefreshIndicator(
        onRefresh: _refreshOperationEntryLines,
        child: ListView(
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                'Columns for $_operationTemplateRowLabel Row',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            operationEntryLines.when(
              data: (data) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          switch (data[index].operationTemplateColumn?.dataType) {
                            case OperationTemplateDataType.int32:
                            case OperationTemplateDataType.decimal:
                              // Ensure the value is a valid number
                              if (double.tryParse(value) != null || value.isEmpty) {
                                _operationEntryLineTemp[index] = _operationEntryLineTemp[index].copyWith(value: value);
                              } else {
                                ref.read(snackbarMessageProvider.notifier).show('Please enter a valid number');
                              }
                              break;
                            case OperationTemplateDataType.dateTime:
                              // Handle dateTime input separately if needed
                              //_operationEntryLineTemp[index] = _operationEntryLineTemp[index].copyWith(value: value);
                              break;
                            default:
                              _operationEntryLineTemp[index] = _operationEntryLineTemp[index].copyWith(value: value);
                          }
                        },
                        controller: TextEditingController(text: switch (_operationEntryLineTemp[index].operationTemplateColumn?.dataType) {
                          OperationTemplateDataType.int32 => _operationEntryLineTemp[index].value ?? '',
                          OperationTemplateDataType.decimal => _operationEntryLineTemp[index].value ?? '',
                          OperationTemplateDataType.dateTime => _operationEntryLineTemp[index].value != null && _operationEntryLineTemp[index].value!.isNotEmpty
                              ? DateFormat.yMMMMd().format(DateTime.parse(_operationEntryLineTemp[index].value!))
                              : '',
                          _ => data[index].value ?? '',
                        }),
                        keyboardType: switch (data[index].operationTemplateColumn?.dataType) {
                          OperationTemplateDataType.int32 => TextInputType.number,
                          OperationTemplateDataType.decimal => const TextInputType.numberWithOptions(decimal: true),
                          OperationTemplateDataType.dateTime => TextInputType.datetime,
                          _ => TextInputType.text,
                        },
                        inputFormatters: switch(data[index].operationTemplateColumn?.dataType) {
                          OperationTemplateDataType.int32 => [FilteringTextInputFormatter.digitsOnly],
                          OperationTemplateDataType.decimal => [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                          OperationTemplateDataType.dateTime => [], // No specific formatter for dateTime
                          _ => [],
                        },
                        readOnly: switch(data[index].operationTemplateColumn?.dataType) {
                          OperationTemplateDataType.int32 => false,
                          OperationTemplateDataType.decimal => false,
                          OperationTemplateDataType.string => false,
                          _ => false, // Read-only for other types
                        },
                        decoration: InputDecoration(
                          labelText: data[index].operationTemplateColumn?.columnLabel,
                          floatingLabelStyle: Environment.floatingLabelStyle,
                          border: const OutlineInputBorder(),
                          suffixIcon: switch (data[index].operationTemplateColumn?.dataType) {
                            OperationTemplateDataType.int32 => const Icon(Icons.numbers),
                            OperationTemplateDataType.decimal => const Icon(Icons.calculate),
                            OperationTemplateDataType.dateTime => IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                // Implement date picker logic here
                                // For example, you can show a date picker dialog
                                // and update the value accordingly.
                                // Note: This is just a placeholder, actual implementation may vary.
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    setState(() {
                                      _operationEntryLineTemp[index] = _operationEntryLineTemp[index].copyWith(value: selectedDate.toIso8601String());
                                    }); // Refresh the UI
                                  }
                                });
                              },
                            ),
                            _ => const Icon(Icons.text_fields),
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) {
                ref.read(snackbarMessageProvider.notifier).show(error.toString());
                return const SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        title: Text('Update Operation Entry Header'),
                        content: Text('Are you sure you want to update this Operation Entry Header?'),
                        onConfirm: () async {
                          try {
                            await ref.read(operationEntryLineProvider(_operationEntryHeaderId).notifier).updateOperationEntryLine(_operationEntryLineTemp);
                            operationEntryLines.whenData((data) => _operationEntryLineTemp = data);
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // set the width of the button to fill the available space
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: Text(
                  'Update Operation Entry Header',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
