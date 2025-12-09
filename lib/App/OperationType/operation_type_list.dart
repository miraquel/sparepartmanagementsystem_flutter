import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationType/operation_type_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationType/operation_type_provider.dart';
import 'package:unicons/unicons.dart';

class OperationTypeList extends ConsumerWidget {
  const OperationTypeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchDto = ref.watch(operationTypeFilterProvider);
    final AsyncValue<List<OperationTypeDto>> operationTypes = ref.watch(operationTypeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Types'),
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
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            searchDto = searchDto.copyWith(
                              description: value.isEmpty ? null : value,
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
                                    ref.read(operationTypeFilterProvider.notifier).setFilter(OperationTypeDto());
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
                                    ref.read(operationTypeFilterProvider.notifier).setFilter(searchDto);
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
          await Navigator.pushNamed(context, '/operationTypeDetails');
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: operationTypes.when(
          data: (operationTypes) {
            if (operationTypes.isEmpty) {
              return const Text('No operation types found.');
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(operationTypeProvider),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black, thickness: 1, height: 0),
                itemCount: operationTypes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(operationTypes[index].name ?? ''),
                    subtitle: Text(operationTypes[index].description ?? 'No description'),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        '/operationTypeDetails',
                        arguments: operationTypes[index].operationTypeId,
                      );
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                            title: const Text('Delete Operation Type'),
                            content: const Text('Are you sure you want to delete this operation type?'),
                            onConfirm: () async {
                              await ref
                                  .read(operationTypeProvider.notifier)
                                  .deleteOperationType(operationTypes[index].operationTypeId!);
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
