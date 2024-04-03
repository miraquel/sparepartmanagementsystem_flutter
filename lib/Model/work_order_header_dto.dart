import '../Helper/date_time_helper.dart';
import 'base_model_dto.dart';
import 'work_order_line_dto.dart';

import 'Constants/no_yes.dart';

class WorkOrderHeaderDto extends BaseModelDto {
  final int workOrderHeaderId;
  final bool? isSubmitted;
  final DateTime submittedDate;
  final String agseamwoid;
  final String agseamwrid;
  final String agseamEntityID;
  final String name;
  final String headerTitle;
  final String agseamPriorityID;
  final String agseamwotype;
  final String agseamwoStatusID;
  final DateTime agseamPlanningStartDate;
  final DateTime agseamPlanningEndDate;
  final NoYes entityShutDown;
  final DateTime woCloseDate;
  final NoYes agseamSuspend;
  final String notes;
  final List<WorkOrderLineDto> workOrderLines;

  WorkOrderHeaderDto({
    this.workOrderHeaderId = 0,
    this.isSubmitted,
    DateTime? submittedDate,
    this.agseamwoid = '',
    this.agseamwrid = '',
    this.agseamEntityID = '',
    this.name = '',
    this.headerTitle = '',
    this.agseamPriorityID = '',
    this.agseamwotype = '',
    this.agseamwoStatusID = '',
    DateTime? agseamPlanningStartDate,
    DateTime? agseamPlanningEndDate,
    this.entityShutDown = NoYes.none,
    DateTime? woCloseDate,
    this.agseamSuspend = NoYes.none,
    this.notes = '',
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
    List<WorkOrderLineDto>? workOrderLines
  }) : submittedDate = submittedDate ?? DateTimeHelper.minDateTime, agseamPlanningStartDate = agseamPlanningStartDate ?? DateTimeHelper.minDateTime, agseamPlanningEndDate = agseamPlanningEndDate ?? DateTimeHelper.minDateTime, woCloseDate = woCloseDate ?? DateTimeHelper.minDateTime, workOrderLines = workOrderLines ?? <WorkOrderLineDto>[], super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory WorkOrderHeaderDto.fromJson(Map<String, dynamic> json) => WorkOrderHeaderDto(
    workOrderHeaderId: json['workOrderHeaderId'] as int? ?? 0,
    isSubmitted: json['isSubmitted'] as bool? ?? false,
    submittedDate: DateTime.tryParse(json['submittedDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    agseamwoid: json['agseamwoid'] as String? ?? '',
    agseamwrid: json['agseamwrid'] as String? ?? '',
    agseamEntityID: json['agseamEntityID'] as String? ?? '',
    name: json['name'] as String? ?? '',
    headerTitle: json['headerTitle'] as String? ?? '',
    agseamPriorityID: json['agseamPriorityID'] as String? ?? '',
    agseamwotype: json['agseamwotype'] as String? ?? '',
    agseamwoStatusID: json['agseamwoStatusID'] as String? ?? '',
    agseamPlanningStartDate: DateTime.tryParse(json['agseamPlanningStartDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    agseamPlanningEndDate: DateTime.tryParse(json['agseamPlanningEndDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    entityShutDown: NoYes.values[json['entityShutDown'] as int? ?? 0],
    woCloseDate: DateTime.tryParse(json['woCloseDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    agseamSuspend: NoYes.values[json['agseamSuspend'] as int? ?? 0],
    notes: json['notes'] as String? ?? '',
    workOrderLines: json['workOrderLines']?.map<WorkOrderLineDto>((e) => WorkOrderLineDto.fromJson(e as Map<String, dynamic>)).toList(),
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      if (workOrderHeaderId != 0) 'workOrderHeaderId': workOrderHeaderId,
      if (isSubmitted != false) 'isSubmitted': isSubmitted,
      if (submittedDate != DateTimeHelper.minDateTime) 'submittedDate': submittedDate.toIso8601String(),
      if (agseamwoid.isNotEmpty) 'agseamwoid': agseamwoid,
      if (agseamwrid.isNotEmpty) 'agseamwrid': agseamwrid,
      if (agseamEntityID.isNotEmpty) 'agseamEntityID': agseamEntityID,
      if (name.isNotEmpty) 'name': name,
      if (headerTitle.isNotEmpty) 'headerTitle': headerTitle,
      if (agseamPriorityID.isNotEmpty) 'agseamPriorityID': agseamPriorityID,
      if (agseamwotype.isNotEmpty) 'agseamwotype': agseamwotype,
      if (agseamwoStatusID.isNotEmpty) 'agseamwoStatusID': agseamwoStatusID,
      if (agseamPlanningStartDate.isAfter(DateTimeHelper.minDateTime)) 'agseamPlanningStartDate': agseamPlanningStartDate.toIso8601String(),
      if (agseamPlanningEndDate.isAfter(DateTimeHelper.minDateTime)) 'agseamPlanningEndDate': agseamPlanningEndDate.toIso8601String(),
      if (entityShutDown != NoYes.none) 'entityShutDown': entityShutDown.index,
      if (woCloseDate.isAfter(DateTimeHelper.minDateTime)) 'woCloseDate': woCloseDate.toIso8601String(),
      if (agseamSuspend != NoYes.none) 'agseamSuspend': agseamSuspend.index,
      if (notes.isNotEmpty) 'notes': notes,
      if (workOrderLines.isNotEmpty) 'workOrderLines': workOrderLines.map((e) => e.toJson()).toList(),
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime != DateTimeHelper.minDateTime) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime != DateTimeHelper.minDateTime) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    };
  }
}