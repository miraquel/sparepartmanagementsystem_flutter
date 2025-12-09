import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_verificator_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplateVerificator/operation_template_verificator_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplateVerificator/operation_template_verificator_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:unicons/unicons.dart';

class OperationTemplateVerificatorList extends ConsumerWidget {
  const OperationTemplateVerificatorList({super.key, required this.operationTemplateId});

  final int operationTemplateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchDto = ref.watch(operationTemplateVerificatorFilterProvider);
    final AsyncValue<List<OperationTemplateVerificatorDto>> operationTemplateVerificators = ref.watch(operationTemplateVerificatorProvider(operationTemplateId));
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
                        // Position, which is an integer, the user can only input numbers
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Job Position',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            searchDto = searchDto.copyWith(
                              jobPosition: value.isEmpty ? null : value,
                            );
                          },
                          initialValue: searchDto.jobPosition
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
                                    ref.read(operationTemplateVerificatorFilterProvider.notifier).clearFilter();
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
                                    ref.read(operationTemplateVerificatorFilterProvider.notifier).setFilter(searchDto);
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
          await Navigator.pushNamed(context, '/operationTemplateVerificatorDetails', arguments: {
            'operationTemplateId': operationTemplateId,
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: operationTemplateVerificators.when(
            data: (operationTemplateVerificators) {
              if (operationTemplateVerificators.isEmpty) {
                return const Text('No operation template verificators found.');
              }
              return RefreshIndicator(
                onRefresh: () async => ref.invalidate(operationTemplateVerificatorProvider),
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black, thickness: 1, height: 0),
                    itemCount: operationTemplateVerificators.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(operationTemplateVerificators[index].name ?? ''),
                        subtitle: Text(operationTemplateVerificators[index].jobPosition ?? ''),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/operationTemplateVerificatorDetails',
                            arguments: {
                              'operationTemplateId': operationTemplateId,
                              'operationTemplateVerificatorId': operationTemplateVerificators[index].operationTemplateVerificatorId,
                            },
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
                                            .read(operationTemplateVerificatorProvider(operationTemplateId).notifier)
                                            .deleteOperationTemplateVerificator(operationTemplateVerificators[index].operationTemplateVerificatorId!);
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
