import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplate/operation_template_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplate/operation_template_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:unicons/unicons.dart';

class OperationTemplateList extends ConsumerWidget {
  const OperationTemplateList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchDto = ref.watch(operationTemplateFilterProvider);
    final AsyncValue<List<OperationTemplateDto>> operationTemplates = ref.watch(operationTemplateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Templates'),
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
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            searchDto = searchDto.copyWith(
                              name: value.isEmpty ? null : value,
                            );
                          },
                          initialValue: searchDto.name,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Document No.',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            searchDto = searchDto.copyWith(
                              documentNo: value.isEmpty ? null : value,
                            );
                          },
                          initialValue: searchDto.description,
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
                                    ref.read(operationTemplateFilterProvider.notifier).clearFilter();
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
                                    ref.read(operationTemplateFilterProvider.notifier).setFilter(searchDto);
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
          await Navigator.pushNamed(context, '/operationTemplateDetails');
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: operationTemplates.when(
            data: (operationTemplates) {
              if (operationTemplates.isEmpty) {
                return const Text('No operation templates found.');
              }
              return RefreshIndicator(
                onRefresh: () async => ref.invalidate(operationTemplateProvider),
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black, thickness: 1, height: 0),
                    itemCount: operationTemplates.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(operationTemplates[index].name ?? ''),
                        //subtitle: Text(operationTemplates[index].description ?? 'No description'),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/operationTemplateDetails',
                            arguments: operationTemplates[index].operationTemplateId,
                          );
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmationDialog(
                                    title: const Text('Delete Operation Template'),
                                    content: const Text('Are you sure you want to delete this operation template?'),
                                    onConfirm: () async {
                                      try {
                                        await ref
                                            .read(operationTemplateProvider.notifier)
                                            .deleteOperationTemplate(operationTemplates[index].operationTemplateId!);
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
