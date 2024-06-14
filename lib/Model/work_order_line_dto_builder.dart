import 'package:sparepartmanagementsystem_flutter/Model/default_dimension_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_ax_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Constants/no_yes.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class WorkOrderLineDtoBuilder {
  int _workOrderLineId = 0;
  int _workOrderHeaderId = 0;
  int _line = 0;
  String _woid = '';
  String _lineTitle = '';
  String _entityId = '';
  NoYes _entityShutdown = NoYes.none;
  String _workOrderType = '';
  String _taskId = '';
  String _condition = '';
  DateTime _planningStartDate = DateTimeHelper.minDateTime;
  DateTime _planningEndDate = DateTimeHelper.minDateTime;
  String _supervisor = '';
  String _calendarId = '';
  String _lineStatus = '';
  NoYes _suspend = NoYes.none;
  DefaultDimensionDtoBuilder _defaultDimension = DefaultDimensionDtoBuilder();
  String _createdBy = '';
  DateTime _createdDateTime = DateTimeHelper.minDateTime;
  String _modifiedBy = '';
  DateTime _modifiedDateTime = DateTimeHelper.minDateTime;
  int _recId = 0;
  bool _isSelected = false;

  WorkOrderLineDtoBuilder();

  int get workOrderLineId => _workOrderLineId;
  int get workOrderHeaderId => _workOrderHeaderId;
  int get line => _line;
  String get woid => _woid;
  String get lineTitle => _lineTitle;
  String get entityId => _entityId;
  NoYes get entityShutdown => _entityShutdown;
  String get workOrderType => _workOrderType;
  String get taskId => _taskId;
  String get condition => _condition;
  DateTime get planningStartDate => _planningStartDate;
  DateTime get planningEndDate => _planningEndDate;
  String get supervisor => _supervisor;
  String get calendarId => _calendarId;
  String get lineStatus => _lineStatus;
  NoYes get suspend => _suspend;
  DefaultDimensionDtoBuilder get defaultDimension => _defaultDimension;
  String get createdBy => _createdBy;
  DateTime get createdDateTime => _createdDateTime;
  String get modifiedBy => _modifiedBy;
  DateTime get modifiedDateTime => _modifiedDateTime;
  int get recId => _recId;
  bool get isSelected => _isSelected;

  factory WorkOrderLineDtoBuilder.fromDto(WorkOrderLineDto model) {
    return WorkOrderLineDtoBuilder()
      .._workOrderLineId = model.workOrderLineId
      .._workOrderHeaderId = model.workOrderHeaderId
      .._line = model.line
      .._woid = model.woid
      .._lineTitle = model.lineTitle
      .._entityId = model.entityId
      .._entityShutdown = model.entityShutdown
      .._workOrderType = model.workOrderType
      .._taskId = model.taskId
      .._condition = model.condition
      .._planningStartDate = model.planningStartDate
      .._planningEndDate = model.planningEndDate
      .._supervisor = model.supervisor
      .._calendarId = model.calendarId
      .._lineStatus = model.lineStatus
      .._suspend = model.suspend
      .._defaultDimension = DefaultDimensionDtoBuilder.fromDto(model.defaultDimension)
      .._createdBy = model.createdBy
      .._createdDateTime = model.createdDateTime
      .._modifiedBy = model.modifiedBy
      .._modifiedDateTime = model.modifiedDateTime
      .._recId = model.recId;
  }

  factory WorkOrderLineDtoBuilder.fromWorkOrderLineAxDto(WorkOrderLineAxDto model) {
    return WorkOrderLineDtoBuilder()
      .._line = model.line
      .._lineTitle = model.lineTitle
      .._entityId = model.entityId
      .._entityShutdown = model.entityShutdown
      .._workOrderType = model.workOrderType
      .._taskId = model.taskId
      .._condition = model.condition
      .._planningStartDate = model.planningStartDate
      .._planningEndDate = model.planningEndDate
      .._supervisor = model.supervisor
      .._calendarId = model.calendarId
      .._lineStatus = model.lineStatus
      .._suspend = model.suspend;
  }

  WorkOrderLineDto build() {
    return WorkOrderLineDto(
      workOrderLineId: _workOrderLineId,
      workOrderHeaderId: _workOrderHeaderId,
      line: _line,
      woid: _woid,
      lineTitle: _lineTitle,
      entityId: _entityId,
      entityShutdown: _entityShutdown,
      workOrderType: _workOrderType,
      taskId: _taskId,
      condition: _condition,
      planningStartDate: _planningStartDate,
      planningEndDate: _planningEndDate,
      supervisor: _supervisor,
      calendarId: _calendarId,
      lineStatus: _lineStatus,
      suspend: _suspend,
      defaultDimension: _defaultDimension.build(),
      createdBy: _createdBy,
      createdDateTime: _createdDateTime,
      modifiedBy: _modifiedBy,
      modifiedDateTime: _modifiedDateTime,
      recId: _recId,
    );
  }

  WorkOrderLineDtoBuilder setFromDto(WorkOrderLineDto model) {
    _workOrderLineId = model.workOrderLineId;
    _workOrderHeaderId = model.workOrderHeaderId;
    _line = model.line;
    _woid = model.woid;
    _lineTitle = model.lineTitle;
    _entityId = model.entityId;
    _entityShutdown = model.entityShutdown;
    _workOrderType = model.workOrderType;
    _taskId = model.taskId;
    _condition = model.condition;
    _planningStartDate = model.planningStartDate;
    _planningEndDate = model.planningEndDate;
    _supervisor = model.supervisor;
    _calendarId = model.calendarId;
    _lineStatus = model.lineStatus;
    _suspend = model.suspend;
    _defaultDimension = DefaultDimensionDtoBuilder.fromDto(model.defaultDimension);
    _createdBy = model.createdBy;
    _createdDateTime = model.createdDateTime;
    _modifiedBy = model.modifiedBy;
    _modifiedDateTime = model.modifiedDateTime;
    _recId = model.recId;
    return this;
  }

  WorkOrderLineDtoBuilder setWorkOrderLineId(int workOrderLineId) {
    _workOrderLineId = workOrderLineId;
    return this;
  }

  WorkOrderLineDtoBuilder setWorkOrderHeaderId(int workOrderHeaderId) {
    _workOrderHeaderId = workOrderHeaderId;
    return this;
  }

  WorkOrderLineDtoBuilder setLine(int line) {
    _line = line;
    return this;
  }

  WorkOrderLineDtoBuilder setWoid(String woid) {
    _woid = woid;
    return this;
  }

  WorkOrderLineDtoBuilder setLineTitle(String lineTitle) {
    _lineTitle = lineTitle;
    return this;
  }

  WorkOrderLineDtoBuilder setEntityId(String entityId) {
    _entityId = entityId;
    return this;
  }

  WorkOrderLineDtoBuilder setEntityShutdown(NoYes entityShutdown) {
    _entityShutdown = entityShutdown;
    return this;
  }

  WorkOrderLineDtoBuilder setWorkOrderType(String workOrderType) {
    _workOrderType = workOrderType;
    return this;
  }

  WorkOrderLineDtoBuilder setTaskId(String taskId) {
    _taskId = taskId;
    return this;
  }

  WorkOrderLineDtoBuilder setCondition(String condition) {
    _condition = condition;
    return this;
  }

  WorkOrderLineDtoBuilder setPlanningStartDate(DateTime planningStartDate) {
    _planningStartDate = planningStartDate;
    return this;
  }

  WorkOrderLineDtoBuilder setPlanningEndDate(DateTime planningEndDate) {
    _planningEndDate = planningEndDate;
    return this;
  }

  WorkOrderLineDtoBuilder setSupervisor(String supervisor) {
    _supervisor = supervisor;
    return this;
  }

  WorkOrderLineDtoBuilder setCalendarId(String calendarId) {
    _calendarId = calendarId;
    return this;
  }

  WorkOrderLineDtoBuilder setLineStatus(String lineStatus) {
    _lineStatus = lineStatus;
    return this;
  }

  WorkOrderLineDtoBuilder setSuspend(NoYes suspend) {
    _suspend = suspend;
    return this;
  }

  WorkOrderLineDtoBuilder setDefaultDimension(DefaultDimensionDtoBuilder defaultDimension) {
    _defaultDimension = defaultDimension;
    return this;
  }

  WorkOrderLineDtoBuilder setCreatedBy(String createdBy) {
    _createdBy = createdBy;
    return this;
  }

  WorkOrderLineDtoBuilder setCreatedDateTime(DateTime createdDateTime) {
    _createdDateTime = createdDateTime;
    return this;
  }

  WorkOrderLineDtoBuilder setModifiedBy(String modifiedBy) {
    _modifiedBy = modifiedBy;
    return this;
  }

  WorkOrderLineDtoBuilder setModifiedDateTime(DateTime modifiedDateTime) {
    _modifiedDateTime = modifiedDateTime;
    return this;
  }

  WorkOrderLineDtoBuilder setRecId(int recId) {
    _recId = recId;
    return this;
  }

  WorkOrderLineDtoBuilder setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }
}