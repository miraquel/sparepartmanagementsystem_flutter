import 'package:sparepartmanagementsystem_flutter/Model/base_model_dto.dart';

import '../Helper/date_time_helper.dart';
import 'Constants/no_yes.dart';

class WorkOrderLineDto extends BaseModelDto {
  final int workOrderLineId;
  final int workOrderHeaderId;
  final int line;
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
  final String workOrderStatus;
  final NoYes suspend;

  WorkOrderLineDto({
    this.workOrderLineId = 0,
    this.workOrderHeaderId = 0,
    this.line = 0,
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
    this.workOrderStatus = '',
    this.suspend = NoYes.none,
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) : planningStartDate = planningStartDate ?? DateTimeHelper.minDateTime, planningEndDate = planningEndDate ?? DateTimeHelper.minDateTime, super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory WorkOrderLineDto.fromJson(Map<String, dynamic> json) {
    return WorkOrderLineDto(
      workOrderLineId: json['workOrderLineId'] as int? ?? 0,
      workOrderHeaderId: json['workOrderHeaderId'] as int? ?? 0,
      line: json['line'] as int? ?? 0,
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
      workOrderStatus: json['workOrderStatus'] as String? ?? '',
      suspend: NoYes.values[json['suspend'] as int? ?? 0],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (workOrderLineId != 0) 'workOrderLineId': workOrderLineId,
      if (workOrderHeaderId != 0) 'workOrderHeaderId': workOrderHeaderId,
      if (line != 0) 'line': line,
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
      if (workOrderStatus.isNotEmpty) 'workOrderStatus': workOrderStatus,
      if (suspend != NoYes.none) 'suspend': suspend.index,
    };
  }

}