// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_entry_header_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationEntryHeaderDto _$OperationEntryHeaderDtoFromJson(
  Map<String, dynamic> json,
) => OperationEntryHeaderDto(
  operationEntryHeaderId: (json['operationEntryHeaderId'] as num?)?.toInt(),
  operationTemplateId: (json['operationTemplateId'] as num?)?.toInt(),
  operationEntryHeaderNumber: json['operationEntryHeaderNumber'] as String?,
  description: json['description'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
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

Map<String, dynamic> _$OperationEntryHeaderDtoToJson(
  OperationEntryHeaderDto instance,
) => <String, dynamic>{
  'operationEntryHeaderId': instance.operationEntryHeaderId,
  'operationTemplateId': instance.operationTemplateId,
  'operationEntryHeaderNumber': instance.operationEntryHeaderNumber,
  'description': instance.description,
  'date': instance.date?.toIso8601String(),
  'createdBy': instance.createdBy,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};
