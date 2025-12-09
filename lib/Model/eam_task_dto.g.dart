// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eam_task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EamTaskDto _$EamTaskDtoFromJson(Map<String, dynamic> json) => EamTaskDto(
  taskId: json['taskId'] as String?,
  taskName: json['taskName'] as String?,
  preventiveType: $enumDecodeNullable(
    _$EamPreventiveTypeEnumMap,
    json['preventiveType'],
  ),
);

Map<String, dynamic> _$EamTaskDtoToJson(EamTaskDto instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'taskName': instance.taskName,
      'preventiveType': _$EamPreventiveTypeEnumMap[instance.preventiveType],
    };

const _$EamPreventiveTypeEnumMap = {
  EamPreventiveType.blank: 0,
  EamPreventiveType.elapsedTime: 1,
  EamPreventiveType.statistic: 2,
};
