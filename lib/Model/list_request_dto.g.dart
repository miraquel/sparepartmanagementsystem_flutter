// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequestDto _$ListRequestDtoFromJson(Map<String, dynamic> json) =>
    ListRequestDto(
      sortBy: json['sortBy'] as String?,
      isSortAscending: json['isSortAscending'] as bool?,
      filters: (json['filters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$ListRequestDtoToJson(ListRequestDto instance) =>
    <String, dynamic>{
      'sortBy': instance.sortBy,
      'isSortAscending': instance.isSortAscending,
      'filters': instance.filters,
    };
