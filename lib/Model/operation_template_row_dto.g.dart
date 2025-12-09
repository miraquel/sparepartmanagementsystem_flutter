// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_template_row_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationTemplateRowDto _$OperationTemplateRowDtoFromJson(
  Map<String, dynamic> json,
) => OperationTemplateRowDto(
  operationTemplateRowId: (json['operationTemplateRowId'] as num?)?.toInt(),
  operationTemplateId: (json['operationTemplateId'] as num?)?.toInt(),
  rowLabel: json['rowLabel'] as String?,
  position: (json['position'] as num?)?.toInt(),
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

Map<String, dynamic> _$OperationTemplateRowDtoToJson(
  OperationTemplateRowDto instance,
) => <String, dynamic>{
  'operationTemplateRowId': instance.operationTemplateRowId,
  'operationTemplateId': instance.operationTemplateId,
  'rowLabel': instance.rowLabel,
  'position': instance.position,
  'createdBy': instance.createdBy,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};
