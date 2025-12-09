import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationType/operation_type_provider.dart';

class OperationEntryHeaderCategory extends ConsumerWidget {
  const OperationEntryHeaderCategory({super.key});

  Widget _buildOperationTypeGrid(List<OperationTypeDto> operationTypes) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
      ),
      itemCount: operationTypes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () async {
                await Navigator.pushNamed(context, '/operationEntryHeaderList', arguments: operationTypes[index]);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.category,
                        color: Colors.blue,
                        size: 40,
                      ),
                      Flexible(
                        child: Text(
                          operationTypes[index].name ?? 'Unknown',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var operationTypes = ref.watch(operationTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Entry Header Category'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(operationTypeProvider);
        },
        child: operationTypes.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(child: Text('No operation types available.'));
            }
            return _buildOperationTypeGrid(data);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
