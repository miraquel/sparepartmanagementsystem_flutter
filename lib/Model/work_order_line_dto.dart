import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Constants/no_yes.dart';
import 'package:sparepartmanagementsystem_flutter/Model/default_dimension_dto.dart';

class WorkOrderLineDto {
  final int workOrderLineId;
  final int workOrderHeaderId;
  final int line;
  final String woid;
  final String lineTitle;
  final String entityId;
  final NoYes entityShutdown;
  final String workOrderType;
  final String taskId;
  final String condition;
  final DateTime planningStartDate;
  final DateTime planningEndDate;
  final String supervisor;
  final String calendarId;
  final String lineStatus;
  final NoYes suspend;
  final DefaultDimensionDto defaultDimension;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;
  final int recId;

  WorkOrderLineDto({
    this.workOrderLineId = 0,
    this.workOrderHeaderId = 0,
    this.line = 0,
    this.woid = '',
    this.lineTitle = '',
    this.entityId = '',
    this.entityShutdown = NoYes.none,
    this.workOrderType = '',
    this.taskId = '',
    this.condition = '',
    DateTime? planningStartDate,
    DateTime? planningEndDate,
    this.supervisor = '',
    this.calendarId = '',
    this.lineStatus = '',
    this.suspend = NoYes.none,
    DefaultDimensionDto? defaultDimension,
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
    this.recId = 0
  }) :  planningStartDate = planningStartDate ?? DateTimeHelper.minDateTime,
        planningEndDate = planningEndDate ?? DateTimeHelper.minDateTime,
        createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime,
        defaultDimension = defaultDimension ?? DefaultDimensionDto();

  factory WorkOrderLineDto.fromJson(Map<String, dynamic> json) {
    return WorkOrderLineDto(
      workOrderLineId: json['workOrderLineId'] as int? ?? 0,
      workOrderHeaderId: json['workOrderHeaderId'] as int? ?? 0,
      line: json['line'] as int? ?? 0,
      woid: json['woid'] as String? ?? '',
      lineTitle: json['lineTitle'] as String? ?? '',
      entityId: json['entityId'] as String? ?? '',
      entityShutdown: NoYes.values[json['entityShutdown'] as int? ?? 0],
      workOrderType: json['workOrderType'] as String? ?? '',
      taskId: json['taskId'] as String? ?? '',
      condition: json['condition'] as String? ?? '',
      planningStartDate: DateTime.tryParse(json['planningStartDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      planningEndDate: DateTime.tryParse(json['planningEndDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      supervisor: json['supervisor'] as String? ?? '',
      calendarId: json['calendarId'] as String? ?? '',
      lineStatus: json['lineStatus'] as String? ?? '',
      suspend: NoYes.values[json['suspend'] as int? ?? 0],
      defaultDimension: DefaultDimensionDto.fromJson(json['defaultDimension'] as Map<String, dynamic>? ?? {}),
      createdBy: json['createdBy'] as String? ?? '',
      createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      modifiedBy: json['modifiedBy'] as String? ?? '',
      modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      recId: json['recId'] as int? ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (workOrderLineId != 0) 'workOrderLineId': workOrderLineId,
      if (workOrderHeaderId != 0) 'workOrderHeaderId': workOrderHeaderId,
      if (line != 0) 'line': line,
      if (woid.isNotEmpty) 'woid': woid,
      if (lineTitle.isNotEmpty) 'lineTitle': lineTitle,
      if (entityId.isNotEmpty) 'entityId': entityId,
      if (entityShutdown != NoYes.none) 'entityShutdown': entityShutdown.index,
      if (workOrderType.isNotEmpty) 'workOrderType': workOrderType,
      if (taskId.isNotEmpty) 'taskId': taskId,
      if (condition.isNotEmpty) 'condition': condition,
      if (planningStartDate != DateTimeHelper.minDateTime) 'planningStartDate': planningStartDate.toIso8601String(),
      if (planningEndDate != DateTimeHelper.minDateTime) 'planningEndDate': planningEndDate.toIso8601String(),
      if (supervisor.isNotEmpty) 'supervisor': supervisor,
      if (calendarId.isNotEmpty) 'calendarId': calendarId,
      if (lineStatus.isNotEmpty) 'lineStatus': lineStatus,
      if (suspend != NoYes.none) 'suspend': suspend.index,
      'defaultDimension': defaultDimension.toJson(),
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime != DateTimeHelper.minDateTime) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime != DateTimeHelper.minDateTime) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
      if (recId != 0) 'recId': recId
    };
  }

}