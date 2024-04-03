import '../Helper/date_time_helper.dart';
import 'Constants/no_yes.dart';

class WorkOrderDto {
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

  WorkOrderDto({
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
  }) : agseamPlanningStartDate = agseamPlanningStartDate ?? DateTimeHelper.minDateTime, agseamPlanningEndDate = agseamPlanningEndDate ?? DateTimeHelper.minDateTime, woCloseDate = woCloseDate ?? DateTimeHelper.minDateTime;

  factory WorkOrderDto.fromJson(Map<String, dynamic> json) {
    return WorkOrderDto(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}