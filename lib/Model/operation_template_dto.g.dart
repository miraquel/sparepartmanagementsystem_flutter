// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_template_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationTemplateDto _$OperationTemplateDtoFromJson(
  Map<String, dynamic> json,
) => OperationTemplateDto(
  operationTemplateId: (json['operationTemplateId'] as num?)?.toInt(),
  operationTypeId: (json['operationTypeId'] as num?)?.toInt(),
  name: json['name'] as String?,
  documentNo: json['documentNo'] as String?,
  revision: json['revision'] as String?,
  effectiveDate:
      json['effectiveDate'] == null
          ? null
          : DateTime.parse(json['effectiveDate'] as String),
  description: json['description'] as String?,
  documentRetentionPeriod: json['documentRetentionPeriod'] as String?,
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

Map<String, dynamic> _$OperationTemplateDtoToJson(
  OperationTemplateDto instance,
) => <String, dynamic>{
  'operationTemplateId': instance.operationTemplateId,
  'operationTypeId': instance.operationTypeId,
  'name': instance.name,
  'documentNo': instance.documentNo,
  'revision': instance.revision,
  'effectiveDate': instance.effectiveDate?.toIso8601String(),
  'description': instance.description,
  'documentRetentionPeriod': instance.documentRetentionPeriod,
  'createdBy': instance.createdBy,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};
