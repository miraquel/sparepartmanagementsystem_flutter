import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto_builder.dart';

import 'Constants/no_yes.dart';

class WorkOrderHeaderDtoBuilder {
  int _workOrderHeaderId = 0;
  bool? _isSubmitted;
  DateTime _submittedDate = DateTimeHelper.minDateTime;
  String _agseamwoid = '';
  String _agseamwrid = '';
  String _agseamEntityID = '';
  String _name = '';
  String _headerTitle = '';
  String _agseamPriorityID = '';
  String _agseamwotype = '';
  String _agseamwoStatusID = '';
  DateTime _agseamPlanningStartDate = DateTimeHelper.minDateTime;
  DateTime _agseamPlanningEndDate = DateTimeHelper.minDateTime;
  NoYes _entityShutDown = NoYes.none;
  DateTime _woCloseDate = DateTimeHelper.minDateTime;
  NoYes _agseamSuspend = NoYes.none;
  String _notes = '';
  List<WorkOrderLineDtoBuilder> _workOrderLines = <WorkOrderLineDtoBuilder>[];

  WorkOrderHeaderDtoBuilder();

  int get workOrderHeaderId => _workOrderHeaderId;
  bool? get isSubmitted => _isSubmitted;
  DateTime get submittedDate => _submittedDate;
  String get agseamwoid => _agseamwoid;
  String get agseamwrid => _agseamwrid;
  String get agseamEntityID => _agseamEntityID;
  String get name => _name;
  String get headerTitle => _headerTitle;
  String get agseamPriorityID => _agseamPriorityID;
  String get agseamwotype => _agseamwotype;
  String get agseamwoStatusID => _agseamwoStatusID;
  DateTime get agseamPlanningStartDate => _agseamPlanningStartDate;
  DateTime get agseamPlanningEndDate => _agseamPlanningEndDate;
  NoYes get entityShutDown => _entityShutDown;
  DateTime get woCloseDate => _woCloseDate;
  NoYes get agseamSuspend => _agseamSuspend;
  String get notes => _notes;
  List<WorkOrderLineDtoBuilder> get workOrderLines => _workOrderLines;

  WorkOrderHeaderDto build() {
    return WorkOrderHeaderDto(
      workOrderHeaderId: _workOrderHeaderId,
      isSubmitted: _isSubmitted,
      submittedDate: _submittedDate,
      agseamwoid: _agseamwoid,
      agseamwrid: _agseamwrid,
      agseamEntityID: _agseamEntityID,
      name: _name,
      headerTitle: _headerTitle,
      agseamPriorityID: _agseamPriorityID,
      agseamwotype: _agseamwotype,
      agseamwoStatusID: _agseamwoStatusID,
      agseamPlanningStartDate: _agseamPlanningStartDate,
      agseamPlanningEndDate: _agseamPlanningEndDate,
      entityShutDown: _entityShutDown,
      woCloseDate: _woCloseDate,
      agseamSuspend: _agseamSuspend,
      notes: _notes,
      workOrderLines: _workOrderLines.map((e) => e.build()).toList(),
    );
  }

  factory WorkOrderHeaderDtoBuilder.fromDto(WorkOrderHeaderDto workOrderHeaderDto) {
    return WorkOrderHeaderDtoBuilder()
      .setWorkOrderHeaderId(workOrderHeaderDto.workOrderHeaderId)
      .setIsSubmitted(workOrderHeaderDto.isSubmitted)
      .setSubmittedDate(workOrderHeaderDto.submittedDate)
      .setAgseamwoid(workOrderHeaderDto.agseamwoid)
      .setAgseamwrid(workOrderHeaderDto.agseamwrid)
      .setAgseamEntityID(workOrderHeaderDto.agseamEntityID)
      .setName(workOrderHeaderDto.name)
      .setHeaderTitle(workOrderHeaderDto.headerTitle)
      .setAgseamPriorityID(workOrderHeaderDto.agseamPriorityID)
      .setAgseamwotype(workOrderHeaderDto.agseamwotype)
      .setAgseamwoStatusID(workOrderHeaderDto.agseamwoStatusID)
      .setAgseamPlanningStartDate(workOrderHeaderDto.agseamPlanningStartDate)
      .setAgseamPlanningEndDate(workOrderHeaderDto.agseamPlanningEndDate)
      .setEntityShutDown(workOrderHeaderDto.entityShutDown)
      .setWoCloseDate(workOrderHeaderDto.woCloseDate)
      .setAgseamSuspend(workOrderHeaderDto.agseamSuspend)
      .setNotes(workOrderHeaderDto.notes)
      .setWorkOrderLines(workOrderHeaderDto.workOrderLines.map((e) => WorkOrderLineDtoBuilder.fromDto(e)).toList());
  }

  WorkOrderHeaderDtoBuilder setWorkOrderHeaderId(int workOrderHeaderId) {
    _workOrderHeaderId = workOrderHeaderId;
    return this;
  }

  WorkOrderHeaderDtoBuilder setIsSubmitted(bool? isSubmitted) {
    _isSubmitted = isSubmitted;
    return this;
  }

  WorkOrderHeaderDtoBuilder setSubmittedDate(DateTime submittedDate) {
    _submittedDate = submittedDate;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamwoid(String agseamwoid) {
    _agseamwoid = agseamwoid;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamwrid(String agseamwrid) {
    _agseamwrid = agseamwrid;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamEntityID(String agseamEntityID) {
    _agseamEntityID = agseamEntityID;
    return this;
  }

  WorkOrderHeaderDtoBuilder setName(String name) {
    _name = name;
    return this;
  }

  WorkOrderHeaderDtoBuilder setHeaderTitle(String headerTitle) {
    _headerTitle = headerTitle;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamPriorityID(String agseamPriorityID) {
    _agseamPriorityID = agseamPriorityID;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamwotype(String agseamwotype) {
    _agseamwotype = agseamwotype;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamwoStatusID(String agseamwoStatusID) {
    _agseamwoStatusID = agseamwoStatusID;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamPlanningStartDate(DateTime agseamPlanningStartDate) {
    _agseamPlanningStartDate = agseamPlanningStartDate;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamPlanningEndDate(DateTime agseamPlanningEndDate) {
    _agseamPlanningEndDate = agseamPlanningEndDate;
    return this;
  }

  WorkOrderHeaderDtoBuilder setEntityShutDown(NoYes entityShutDown) {
    _entityShutDown = entityShutDown;
    return this;
  }

  WorkOrderHeaderDtoBuilder setWoCloseDate(DateTime woCloseDate) {
    _woCloseDate = woCloseDate;
    return this;
  }

  WorkOrderHeaderDtoBuilder setAgseamSuspend(NoYes agseamSuspend) {
    _agseamSuspend = agseamSuspend;
    return this;
  }

  WorkOrderHeaderDtoBuilder setNotes(String notes) {
    _notes = notes;
    return this;
  }

  WorkOrderHeaderDtoBuilder setWorkOrderLines(List<WorkOrderLineDtoBuilder> workOrderLines) {
    _workOrderLines = workOrderLines;
    return this;
  }

  WorkOrderHeaderDtoBuilder addWorkOrderLine(WorkOrderLineDtoBuilder workOrderLine) {
    _workOrderLines.add(workOrderLine);
    return this;
  }

  WorkOrderHeaderDtoBuilder addWorkOrderLines(List<WorkOrderLineDtoBuilder> workOrderLines) {
    _workOrderLines.addAll(workOrderLines);
    return this;
  }

  WorkOrderHeaderDtoBuilder removeWorkOrderLine(WorkOrderLineDtoBuilder workOrderLine) {
    _workOrderLines.remove(workOrderLine);
    return this;
  }

  WorkOrderHeaderDtoBuilder removeWorkOrderLines(List<WorkOrderLineDtoBuilder> workOrderLines) {
    _workOrderLines.removeWhere((element) => workOrderLines.contains(element));
    return this;
  }

  WorkOrderHeaderDtoBuilder clearWorkOrderLines() {
    _workOrderLines.clear();
    return this;
  }

  WorkOrderHeaderDtoBuilder deleteSelectedWorkOrderLines() {
    _workOrderLines.removeWhere((element) => element.isSelected);
    return this;
  }

  bool isAtLeastOneWorkOrderLineSelected() {
    return _workOrderLines.any((element) => element.isSelected);
  }

  bool isNoWorkOrderLineSelected() {
    return _workOrderLines.every((element) => !element.isSelected);
  }

  bool isAllWorkOrderLinesSelected() {
    return _workOrderLines.every((element) => element.isSelected);
  }

  WorkOrderHeaderDtoBuilder selectAllWorkOrderLines() {
    for (var element in _workOrderLines) {
      element.setIsSelected(true);
    }
    return this;
  }

  WorkOrderHeaderDtoBuilder deselectAllWorkOrderLines() {
    for (var element in _workOrderLines) {
      element.setIsSelected(false);
    }
    return this;
  }
}