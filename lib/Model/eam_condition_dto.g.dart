// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eam_condition_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EamConditionDto _$EamConditionDtoFromJson(Map<String, dynamic> json) =>
    EamConditionDto(
      condition: json['condition'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$EamConditionDtoToJson(EamConditionDto instance) =>
    <String, dynamic>{
      'condition': instance.condition,
      'description': instance.description,
    };
