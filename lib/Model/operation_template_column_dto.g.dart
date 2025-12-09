// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_template_column_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationTemplateColumnDto _$OperationTemplateColumnDtoFromJson(
  Map<String, dynamic> json,
) => OperationTemplateColumnDto(
  operationTemplateColumnId:
      (json['operationTemplateColumnId'] as num?)?.toInt(),
  operationTemplateId: (json['operationTemplateId'] as num?)?.toInt(),
  columnLabel: json['columnLabel'] as String?,
  dataType: $enumDecodeNullable(
    _$OperationTemplateDataTypeEnumMap,
    json['dataType'],
  ),
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

Map<String, dynamic> _$OperationTemplateColumnDtoToJson(
  OperationTemplateColumnDto instance,
) => <String, dynamic>{
  'operationTemplateColumnId': instance.operationTemplateColumnId,
  'operationTemplateId': instance.operationTemplateId,
  'columnLabel': instance.columnLabel,
  'dataType': _$OperationTemplateDataTypeEnumMap[instance.dataType],
  'position': instance.position,
  'createdBy': instance.createdBy,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};

const _$OperationTemplateDataTypeEnumMap = {
  OperationTemplateDataType.empty: 0,
  OperationTemplateDataType.boolean: 3,
  OperationTemplateDataType.char: 4,
  OperationTemplateDataType.int32: 9,
  OperationTemplateDataType.uint32: 10,
  OperationTemplateDataType.int64: 11,
  OperationTemplateDataType.uint64: 12,
  OperationTemplateDataType.double: 14,
  OperationTemplateDataType.decimal: 15,
  OperationTemplateDataType.dateTime: 16,
  OperationTemplateDataType.string: 18,
};
