import 'package:flutter/material.dart';

import '../DataAccessLayer/Abstract/work_order_dal.dart';
import '../service_locator_setup.dart';

class WorkOrderAdd extends StatefulWidget {
  const WorkOrderAdd({super.key});

  @override
  State<WorkOrderAdd> createState() => _WorkOrderAddState();
}

class _WorkOrderAddState extends State<WorkOrderAdd> {
  final _workOrderDAL = locator<WorkOrderDAL>();

  Future<void> _saveWorkOrder() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Order Add'),
      ),
      body: const Center(
        child: Text('Work Order Add'),
      ),
    );
  }
}
