import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/dimension_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkOrderDirectLineDetails extends StatefulWidget {
  final WorkOrderLineDto workOrderLineDto;
  const WorkOrderDirectLineDetails({super.key, required this.workOrderLineDto});

  @override
  State<WorkOrderDirectLineDetails> createState() =>
      _WorkOrderDirectLineDetailsState();
}

class _WorkOrderDirectLineDetailsState extends State<WorkOrderDirectLineDetails>
    with SingleTickerProviderStateMixin {
  final _workOrderLineDAL = locator<WorkOrderDirectDAL>();
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _workOrderLineDtoBuilder = WorkOrderLineDtoBuilder();
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  late NavigatorState _navigator;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    _workOrderLineDtoBuilder.setFromDto(widget.workOrderLineDto);
  }

  Future<void> _getWorkOrderLine() async {
    try {
      setState(() => _isLoading = true);
      final response = await _workOrderLineDAL.getWorkOrderLine(
          widget.workOrderLineDto.woid, widget.workOrderLineDto.line);
      if (response.success) {
        _workOrderLineDtoBuilder.setFromDto(response.data!);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Work Order Line Details'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Details'),
              Tab(text: 'Financial Dimensions')
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _getWorkOrderLine,
            )
          ],
        ),
        body: TabBarView(
            controller: _tabController,
            children: [_workOrderLineDetails(), _financialDimensions()]),
      ),
    );
  }

  Widget _workOrderLineDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 5),
            child: ElevatedButton(
              onPressed: () async {
                await _navigator.pushNamed('/itemRequisitionDirectList',
                    arguments: widget.workOrderLineDto);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Item requisitions',
                  style: TextStyle(fontSize: 17, color: Colors.white)),
            ),
          ),
          ListTile(
            title: const Text('Line'),
            subtitle: Text(_workOrderLineDtoBuilder.line.toString()),
          ),
          ListTile(
            title: const Text('Line Title'),
            subtitle: Text(_workOrderLineDtoBuilder.lineTitle),
          ),
          ListTile(
            title: const Text('Entity Id'),
            subtitle: Text(_workOrderLineDtoBuilder.entityId),
          ),
          ListTile(
            title: const Text('Entity Shutdown'),
            subtitle: Text(_workOrderLineDtoBuilder.entityShutdown.toString()),
          ),
          ListTile(
            title: const Text('Work Order Type'),
            subtitle: Text(_workOrderLineDtoBuilder.workOrderType),
          ),
          ListTile(
            title: const Text('Task Id'),
            subtitle: Text(_workOrderLineDtoBuilder.taskId),
          ),
          ListTile(
            title: const Text('Condition'),
            subtitle: Text(_workOrderLineDtoBuilder.condition),
          ),
          ListTile(
            title: const Text('Planning Start Date'),
            subtitle:
                Text(_workOrderLineDtoBuilder.planningStartDate.toString()),
          ),
          ListTile(
            title: const Text('Planning End Date'),
            subtitle: Text(_workOrderLineDtoBuilder.planningEndDate.toString()),
          ),
          ListTile(
            title: const Text('Supervisor'),
            subtitle: Text(_workOrderLineDtoBuilder.supervisor),
          ),
          ListTile(
            title: const Text('Calendar Id'),
            subtitle: Text(_workOrderLineDtoBuilder.calendarId),
          ),
          ListTile(
            title: const Text('Line Status'),
            subtitle: Text(_workOrderLineDtoBuilder.lineStatus),
          ),
          ListTile(
            title: const Text('Suspend'),
            subtitle: Text(_workOrderLineDtoBuilder.suspend.toString()),
          ),
        ],
      ),
    );
  }

  Widget _financialDimensions() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Financial Dimensions',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text(
                      'Dimension values are used to categorize transactions and to provide additional information about transactions. The default dimension values are used when no other dimension values are specified.'),
                  ...[
                    // _financialDimensionField('Bank', _workOrderLineDtoBuilder.defaultDimension.bank,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setBank(value!.value))),
                    // _financialDimensionField('Brand', _workOrderLineDtoBuilder.defaultDimension.brand,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setBrand(value!.value))),
                    // _financialDimensionField('BusinessUnit', _workOrderLineDtoBuilder.defaultDimension.businessUnit,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setBusinessUnit(value!.value))),
                    _financialDimensionField('CostCenter', _workOrderLineDtoBuilder.defaultDimension.costCenter,
                        (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setCostCenter(value!.value))),
                    // _financialDimensionField('CustLevel2', _workOrderLineDtoBuilder.defaultDimension.custLevel2,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setCustLevel2(value!.value))),
                    // _financialDimensionField('Customer', _workOrderLineDtoBuilder.defaultDimension.customer,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setCustomer(value!.value))),
                    _financialDimensionField('Department', _workOrderLineDtoBuilder.defaultDimension.department,
                        (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setDepartment(value!.value))),
                    // _financialDimensionField('Distributor', _workOrderLineDtoBuilder.defaultDimension.distributor,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setDistributor(value!.value))),
                    // _financialDimensionField('Divisi', _workOrderLineDtoBuilder.defaultDimension.divisi,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setDivisi(value!.value))),
                    // _financialDimensionField('Investment', _workOrderLineDtoBuilder.defaultDimension.investment,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setInvestment(value!.value))),
                    // _financialDimensionField('SubDistributor', _workOrderLineDtoBuilder.defaultDimension.subDistributor,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setSubDistributor(value!.value))),
                    // _financialDimensionField('Worker', _workOrderLineDtoBuilder.defaultDimension.worker,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setWorker(value!.value))),
                    // _financialDimensionField('WorkerStatus', _workOrderLineDtoBuilder.defaultDimension.workerStatus,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setWorkerStatus(value!.value))),
                    // _financialDimensionField('WorkerType', _workOrderLineDtoBuilder.defaultDimension.workerType,
                    //     (value) async => setState(() => _workOrderLineDtoBuilder.defaultDimension.setWorkerType(value!.value))),
                  ].map((e) => Padding(padding: const EdgeInsets.only(top: 10), child: e)),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await _workOrderLineDAL.updateWorkOrderLine(_workOrderLineDtoBuilder.build());
          },
          child: const Text('Save'),
        )
      ],
    );
  }

  DropdownSearch<DimensionDto> _financialDimensionField(
    String dimensionName,
    String selectedDimension,
    Future<void> Function(DimensionDto?)? onChanged,
  ) {
    return DropdownSearch<DimensionDto>(
      validator: (value) {
        if (value == null) {
          return 'Please select $dimensionName';
        }
        return null;
      },
      selectedItem: DimensionDto(value: selectedDimension),
      dropdownBuilder: (context, selectedItem) {
        return selectedItem != null
            ? Text(selectedItem.value)
            : const SizedBox();
      },
      asyncItems: (String searchTerm) async {
        var result =
            await _gmkSMSServiceGroupDAL.getDimensionList(dimensionName);
        return result.data!;
      },
      enabled: !_isLoading,
      onChanged: onChanged,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        constraints: const BoxConstraints(maxHeight: 300),
        itemBuilder:
            (BuildContext context, DimensionDto item, bool isSelected) {
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
              title: Text("${item.value} - ${item.description}"),
            ),
          );
        },
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              labelText: dimensionName,
              hintText: "Select $dimensionName",
              border: const OutlineInputBorder())),
    );
  }
}
