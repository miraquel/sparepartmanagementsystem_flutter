// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_entry_verification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationEntryVerificationDto _$OperationEntryVerificationDtoFromJson(
  Map<String, dynamic> json,
) => OperationEntryVerificationDto(
  operationEntryVerificationId:
      (json['operationEntryVerificationId'] as num).toInt(),
  operationEntryHeaderId: (json['operationEntryHeaderId'] as num).toInt(),
  operationTemplateVerificatorId:
      (json['operationTemplateVerificatorId'] as num).toInt(),
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

Map<String, dynamic> _$OperationEntryVerificationDtoToJson(
  OperationEntryVerificationDto instance,
) => <String, dynamic>{
  'operationEntryVerificationId': instance.operationEntryVerificationId,
  'operationEntryHeaderId': instance.operationEntryHeaderId,
  'operationTemplateVerificatorId': instance.operationTemplateVerificatorId,
  'createdBy': instance.createdBy,
  'createdDateTime': instance.createdDateTime?.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'modifiedDateTime': instance.modifiedDateTime?.toIso8601String(),
};
