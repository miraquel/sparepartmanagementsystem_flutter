// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkRequestDto _$WorkRequestDtoFromJson(Map<String, dynamic> json) =>
    WorkRequestDto(
      agsDepartment: json['agsDepartment'] as String?,
      agseamCondition: json['agseamCondition'] as String?,
      agseamCriticalityID: json['agseamCriticalityID'] as String?,
      agseamCustSatisfaction: json['agseamCustSatisfaction'] as String?,
      agseamEntityID: json['agseamEntityID'] as String?,
      agseamEntityName: json['agseamEntityName'] as String?,
      agseamEstimate: (json['agseamEstimate'] as num?)?.toDouble(),
      agseamManager: json['agseamManager'] as String?,
      agseamPlanner: json['agseamPlanner'] as String?,
      agseamPlanningEndDate:
          json['agseamPlanningEndDate'] == null
              ? null
              : DateTime.parse(json['agseamPlanningEndDate'] as String),
      agseamPlanningStartDate:
          json['agseamPlanningStartDate'] == null
              ? null
              : DateTime.parse(json['agseamPlanningStartDate'] as String),
      agseamPriorityId: json['agseamPriorityId'] as String?,
      agseamSinder: json['agseamSinder'] as String?,
      agseamStatusWr: (json['agseamStatusWr'] as num?)?.toInt(),
      agseamSupervisor: json['agseamSupervisor'] as String?,
      agseamSuspend: (json['agseamSuspend'] as num?)?.toInt(),
      agseamTaskID: json['agseamTaskID'] as String?,
      agseamTrade: json['agseamTrade'] as String?,
      agseamWoId: json['agseamWoId'] as String?,
      agseamwrid: json['agseamwrid'] as String?,
      disposisiManager: json['disposisiManager'] as String?,
      endDatePlanning:
          json['endDatePlanning'] == null
              ? null
              : DateTime.parse(json['endDatePlanning'] as String),
      entityShutDown: (json['entityShutDown'] as num?)?.toInt(),
      hcmPersonnelNumberId: json['hcmPersonnelNumberId'] as String?,
      ledgerAccount: json['ledgerAccount'] as String?,
      ledgerDimension: json['ledgerDimension'] as num?,
      requestorName: json['requestorName'] as String?,
      saranSinder: json['saranSinder'] as String?,
      startDatePlanning:
          json['startDatePlanning'] == null
              ? null
              : DateTime.parse(json['startDatePlanning'] as String),
      wrNotes: json['wrNotes'] as String?,
      wrTitle: json['wrTitle'] as String?,
      wrkCtrId: json['wrkCtrId'] as String?,
      workflowStatus: $enumDecodeNullable(
        _$EamWorkflowStatusEnumMap,
        json['workflowStatus'],
      ),
      recId: json['recId'] as num?,
      createdDateTime:
          json['createdDateTime'] == null
              ? null
              : DateTime.parse(json['createdDateTime'] as String),
      modifiedDateTime:
          json['modifiedDateTime'] == null
              ? null
              : DateTime.parse(json['modifiedDateTime'] as String),
    );

Map<String, dynamic> _$WorkRequestDtoToJson(
  WorkRequestDto instance,
) => <String, dynamic>{
  'agsDepartment': instance.agsDepartment,
  'agseamCondition': instance.agseamCondition,
  'agseamCriticalityID': instance.agseamCriticalityID,
  'agseamCustSatisfaction': instance.agseamCustSatisfaction,
  'agseamEntityID': instance.agseamEntityID,
  'agseamEntityName': instance.agseamEntityName,
  'agseamEstimate': instance.agseamEstimate,
  'agseamManager': instance.agseamManager,
  'agseamPlanner': instance.agseamPlanner,
  'agseamPlanningEndDate': instance.agseamPlanningEndDate?.toIso8601String(),
  'agseamPlanningStartDate':
      instance.agseamPlanningStartDate?.toIso8601String(),
  'agseamPriorityId': instance.agseamPriorityId,
  'agseamSinder': instance.agseamSinder,
  'agseamStatusWr': instance.agseamStatusWr,
  'agseamSupervisor': instance.agseamSupervisor,
  'agseamSuspend': instance.agseamSuspend,
  'agseamTaskID': instance.agseamTaskID,
  'agseamTrade': instance.agseamTrade,
  'agseamWoId': instance.agseamWoId,
  'agseamwrid': instance.agseamwrid,
  'disposisiManager': instance.disposisiManager,
  'endDatePlanning': instance.endDatePlanning?.toIso8601String(),
  'entityShutDown': instance.entityShutDown,
  'hcmPersonnelNumberId': instance.hcmPersonnelNumberId,
  'ledgerAccount': instance.ledgerAccount,
  'ledgerDimension': instance.ledgerDimension,
  'requestorName': instance.requestorName,
  'saranSinder': instance.saranSinder,
  'startDatePlanning': instance.startDatePlanning?.toIso8601String(),
  'wrNotes': instance.wrNotes,
  'wrTitle': instance.wrTitle,
  'wrkCtrId': instance.wrkCtrId,
  'workflowStatus': _$EamWorkflowStatusEnumMap[instance.workflowStatus],
  'recId': instance.recId,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};

const _$EamWorkflowStatusEnumMap = {
  EamWorkflowStatus.notSubmitted: 0,
  EamWorkflowStatus.submitted: 1,
  EamWorkflowStatus.approved: 2,
  EamWorkflowStatus.rejected: 3,
  EamWorkflowStatus.pendingApproval: 4,
  EamWorkflowStatus.cancel: 5,
  EamWorkflowStatus.accepted: 6,
  EamWorkflowStatus.requestChange: 7,
};
