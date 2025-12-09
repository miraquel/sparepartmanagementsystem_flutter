import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationEntryHeader/operation_entry_header_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationEntryHeader/operation_entry_header_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplate/operation_template_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:unicons/unicons.dart';

class OperationEntryHeaderList extends ConsumerStatefulWidget {
  const OperationEntryHeaderList({super.key, required this.operationType});

  final OperationTypeDto operationType;

  @override
  ConsumerState<OperationEntryHeaderList> createState() => _OperationEntryHeaderListState();
}

class _OperationEntryHeaderListState extends ConsumerState<OperationEntryHeaderList> {

  var searchDto = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    
    searchDto = {
      'operationTypeId': widget.operationType.operationTypeId,
    };

    ref.read(operationEntryHeaderFilterProvider.notifier).setFilter(searchDto);
  }

  @override
  Widget build(BuildContext context) {
    var operationTemplates = ref.watch(operationTemplateProvider);
    var operationEntryHeaders = ref.watch(operationEntryHeaderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Entry Headers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Operation Entry Header Number',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            searchDto['operationEntryHeaderNumber'] = value.isEmpty ? null : value;
                          },
                          initialValue: searchDto['operationEntryHeaderNumber'] ?? '',
                        ),
                        operationTemplates.when(
                          data: (data) {
                            return DropdownSearch<OperationTemplateDto>.multiSelection(
                              items: (f, cs) => data,
                              compareFn: (OperationTemplateDto i, OperationTemplateDto s) => i.operationTemplateId == s.operationTemplateId,
                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Select Operation Template",
                                ),
                              ),
                              selectedItems: searchDto['operationTemplateIds'] != null
                                  ? data.where((e) => searchDto['operationTemplateIds'].contains(e.operationTemplateId)).toList()
                                  : [],
                              onChanged: (List<OperationTemplateDto> selectedItems) => searchDto['operationTemplateIds'] = selectedItems.map((e) => e.operationTemplateId).toList(),
                              dropdownBuilder: (context, selectedItem) {
                                return Wrap(
                                  spacing: 8.0,
                                  runSpacing: -10.0,
                                  children: selectedItem.map((e) => Chip(label: Text(e.name ?? ''))).toList(),
                                );
                              },
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
                            );
                          },
                          error: (error, stackTrace) => const Text('Error loading operation templates'),
                          loading: () => const LinearProgressIndicator(),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only (right: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    // make the color blue
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    ref.read(operationEntryHeaderFilterProvider.notifier).clearFilter();
                                    Navigator.pop(context);
                                  },
                                  // child Text widget with Search text and magnifying glass icon
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Clear', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Icon(UniconsLine.trash, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    // make the color blue
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    ref.read(operationEntryHeaderFilterProvider.notifier).setFilter(searchDto);
                                    Navigator.pop(context);
                                  },
                                  // child Text widget with Search text and magnifying glass icon
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Search', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Icon(UniconsLine.search, color: Colors.white, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ].map((e) => Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 10), child: e)).toList(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/operationEntryHeaderDetails');
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: operationEntryHeaders.when(
            data: (operationEntryHeaders) {
              if (operationEntryHeaders.isEmpty) {
                return const Text('No operation entry headers found.');
              }
              return RefreshIndicator(
                onRefresh: () async => ref.invalidate(operationEntryHeaderProvider),
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black, thickness: 1, height: 0),
                    itemCount: operationEntryHeaders.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(operationEntryHeaders[index].operationEntryHeaderNumber ?? ''),
                        subtitle: ref.read(operationTemplateProvider).when(
                          data: (operationTemplates) {
                            var operationTemplate = operationTemplates.firstWhere(
                              (e) => e.operationTemplateId == operationEntryHeaders[index].operationTemplateId,
                              orElse: () => OperationTemplateDto(),
                            );
                            return Text(operationTemplate.name ?? 'No operation template');
                          },
                          error: (error, stackTrace) => const Text('Error loading operation templates'),
                          loading: () => const LinearProgressIndicator()
                        ),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/operationEntryHeaderDetails',
                            arguments: operationEntryHeaders[index].operationEntryHeaderId,
                          );
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmationDialog(
                                    title: const Text('Delete Operation Entry Header'),
                                    content: const Text('Are you sure you want to delete this operation entry header?'),
                                    onConfirm: () async {
                                      try {
                                        await ref
                                            .read(operationEntryHeaderProvider.notifier)
                                            .deleteOperationEntryHeader(operationEntryHeaders[index].operationEntryHeaderId!);
                                      }
                                      on DioException catch (e) {
                                        var data = ApiResponseDto.fromJson(e.response?.data as Map<String, dynamic>);
                                        ref.read(snackbarMessageProvider.notifier).show(
                                          data.errorMessages.isNotEmpty ? data.errorMessages.first : data.message,
                                        );
                                      }
                                    }
                                );
                              }
                          );
                        },
                      );
                    }
                ),
              );
            },
            error: (error, stackTrace) {
              return Text('Error: $error');
            },
            loading: () => const CircularProgressIndicator(),
          )
      ),
    );
  }
}
