// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationTypeDto _$OperationTypeDtoFromJson(Map<String, dynamic> json) =>
    OperationTypeDto(
      operationTypeId: (json['operationTypeId'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
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

Map<String, dynamic> _$OperationTypeDtoToJson(OperationTypeDto instance) =>
    <String, dynamic>{
      'operationTypeId': instance.operationTypeId,
      'name': instance.name,
      'description': instance.description,
      'createdBy': instance.createdBy,
      'createdDateTime': instance.createdDateTime?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
    };
