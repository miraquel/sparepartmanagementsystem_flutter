// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_template_verificator_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationTemplateVerificatorDto _$OperationTemplateVerificatorDtoFromJson(
  Map<String, dynamic> json,
) => OperationTemplateVerificatorDto(
  operationTemplateVerificatorId:
      (json['operationTemplateVerificatorId'] as num?)?.toInt(),
  operationTemplateId: (json['operationTemplateId'] as num?)?.toInt(),
  name: json['name'] as String?,
  jobPosition: json['jobPosition'] as String?,
  label: json['label'] as String?,
  createdBy: json['createdBy'] as String?,
  createdDateTime:
      json['createdDateTime'] == null
          ? null
          : DateTime.parse(json['createdDateTime'] as String),
  modifiedBy: json['modifiedBy'] as String?,
  modifiedDateTime:
      json['modifiedDateTime'] == null
          ? null
          : DateTime.parse(json['modifiedDateTime'] as String),
);

Map<String, dynamic> _$OperationTemplateVerificatorDtoToJson(
  OperationTemplateVerificatorDto instance,
) => <String, dynamic>{
  'operationTemplateVerificatorId': instance.operationTemplateVerificatorId,
  'operationTemplateId': instance.operationTemplateId,
  'name': instance.name,
  'jobPosition': instance.jobPosition,
  'label': instance.label,
  'createdBy': instance.createdBy,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};
