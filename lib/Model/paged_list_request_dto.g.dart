// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_list_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedListRequestDto _$PagedListRequestDtoFromJson(Map<String, dynamic> json) =>
    PagedListRequestDto(
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      sortBy: json['sortBy'] as String?,
      isSortAscending: json['isSortAscending'] as bool?,
      filters: (json['filters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$PagedListRequestDtoToJson(
  PagedListRequestDto instance,
) => <String, dynamic>{
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
  if (instance.sortBy case final value?) 'sortBy': value,
  if (instance.isSortAscending case final value?) 'isSortAscending': value,
  if (instance.filters case final value?) 'filters': value,
};
