import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_list_request_dto.freezed.dart';
part 'paged_list_request_dto.g.dart';

@freezed
@JsonSerializable(includeIfNull: false)
class PagedListRequestDto with _$PagedListRequestDto {
  @override
  final int pageNumber;
  @override
  final int pageSize;
  @override
  final String? sortBy;
  @override
  final bool? isSortAscending;
  @override
  final Map<String, String>? filters;

  PagedListRequestDto({
    this.pageNumber = 1,
    this.pageSize = 10,
    this.sortBy,
    this.isSortAscending,
    this.filters
  });

  factory PagedListRequestDto.fromJson(Map<String, dynamic> json) => _$PagedListRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PagedListRequestDtoToJson(this);
}