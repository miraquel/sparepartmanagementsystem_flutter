import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';

class WorkOrderLineAdd extends StatefulWidget {
  const WorkOrderLineAdd({super.key});

  @override
  State<WorkOrderLineAdd> createState() => _WorkOrderLineAddState();
}

class _WorkOrderLineAddState extends State<WorkOrderLineAdd> {
  final _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Work Order Line Add'),
          ),
          body: const Center(
            child: Text('Work Order Line Add'),
          ),
        )
    );
  }
}
