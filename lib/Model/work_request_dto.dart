import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/eam_workflow_status.dart';

part 'work_request_dto.freezed.dart';
part 'work_request_dto.g.dart';

@freezed
@JsonSerializable()
class WorkRequestDto with _$WorkRequestDto {
  @override
  final String? agsDepartment;
  @override
  final String? agseamCondition;
  @override
  final String? agseamCriticalityID;
  @override
  final String? agseamCustSatisfaction;
  @override
  final String? agseamEntityID;
  @override
  final String? agseamEntityName;
  @override
  final double? agseamEstimate;
  @override
  final String? agseamManager;
  @override
  final String? agseamPlanner;
  @override
  final DateTime? agseamPlanningEndDate;
  @override
  final DateTime? agseamPlanningStartDate;
  @override
  final String? agseamPriorityId;
  @override
  final String? agseamSinder;
  @override
  final int? agseamStatusWr;
  @override
  final String? agseamSupervisor;
  @override
  final int? agseamSuspend;
  @override
  final String? agseamTaskID;
  @override
  final String? agseamTrade;
  @override
  final String? agseamWoId;
  @override
  final String? agseamwrid;
  @override
  final Map<int, String>? dimension = {};
  @override
  final String? disposisiManager;
  @override
  final DateTime? endDatePlanning;
  @override
  final int? entityShutDown;
  @override
  final String? hcmPersonnelNumberId;
  @override
  final String? ledgerAccount;
  @override
  final num? ledgerDimension;
  @override
  final String? requestorName;
  @override
  final String? saranSinder;
  @override
  final DateTime? startDatePlanning;
  @override
  final String? wrNotes;
  @override
  final String? wrTitle;
  @override
  final String? wrkCtrId;
  @override
  final EamWorkflowStatus? workflowStatus;
  @override
  final num? recId;
  @override
  final DateTime? createdDateTime;
  @override
  final DateTime? modifiedDateTime;

  WorkRequestDto({
    this.agsDepartment,
    this.agseamCondition,
    this.agseamCriticalityID,
    this.agseamCustSatisfaction,
    this.agseamEntityID,
    this.agseamEntityName,
    this.agseamEstimate,
    this.agseamManager,
    this.agseamPlanner,
    this.agseamPlanningEndDate,
    this.agseamPlanningStartDate,
    this.agseamPriorityId,
    this.agseamSinder,
    this.agseamStatusWr,
    this.agseamSupervisor,
    this.agseamSuspend,
    this.agseamTaskID,
    this.agseamTrade,
    this.agseamWoId,
    this.agseamwrid,
    this.disposisiManager,
    this.endDatePlanning,
    this.entityShutDown,
    this.hcmPersonnelNumberId,
    this.ledgerAccount,
    this.ledgerDimension,
    this.requestorName,
    this.saranSinder,
    this.startDatePlanning,
    this.wrNotes,
    this.wrTitle,
    this.wrkCtrId,
    this.workflowStatus,
    this.recId,
    this.createdDateTime,
    this.modifiedDateTime,
  });

  factory WorkRequestDto.fromJson(Map<String, dynamic> json) => _$WorkRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WorkRequestDtoToJson(this);
}