import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_request_dto.freezed.dart';
part 'list_request_dto.g.dart';

@freezed
@JsonSerializable()
class ListRequestDto with _$ListRequestDto {
  @override
  final String? sortBy;
  @override
  final bool? isSortAscending;
  @override
  final Map<String, String>? filters;

  ListRequestDto({
    this.sortBy,
    this.isSortAscending,
    this.filters,
  });

  factory ListRequestDto.fromJson(Map<String, dynamic> json) => _$ListRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ListRequestDtoToJson(this);
}