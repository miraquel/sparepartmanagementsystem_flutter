// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_entry_line_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationEntryLineDto _$OperationEntryLineDtoFromJson(
  Map<String, dynamic> json,
) => OperationEntryLineDto(
  operationEntryLineId: (json['operationEntryLineId'] as num).toInt(),
  operationEntryHeaderId: (json['operationEntryHeaderId'] as num).toInt(),
  operationTemplateRowId: (json['operationTemplateRowId'] as num).toInt(),
  operationTemplateColumnId: (json['operationTemplateColumnId'] as num).toInt(),
  value: json['value'] as String?,
  operationTemplateRow:
      json['operationTemplateRow'] == null
          ? null
          : OperationTemplateRowDto.fromJson(
            json['operationTemplateRow'] as Map<String, dynamic>,
          ),
  operationTemplateColumn:
      json['operationTemplateColumn'] == null
          ? null
          : OperationTemplateColumnDto.fromJson(
            json['operationTemplateColumn'] as Map<String, dynamic>,
          ),
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

Map<String, dynamic> _$OperationEntryLineDtoToJson(
  OperationEntryLineDto instance,
) => <String, dynamic>{
  'operationEntryLineId': instance.operationEntryLineId,
  'operationEntryHeaderId': instance.operationEntryHeaderId,
  'operationTemplateRowId': instance.operationTemplateRowId,
  'operationTemplateColumnId': instance.operationTemplateColumnId,
  'value': instance.value,
  'operationTemplateRow': instance.operationTemplateRow,
  'operationTemplateColumn': instance.operationTemplateColumn,
  'createdBy': instance.createdBy,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};
