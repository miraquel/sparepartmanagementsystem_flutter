import 'package:freezed_annotation/freezed_annotation.dart';

part 'eam_condition_dto.freezed.dart';
part 'eam_condition_dto.g.dart';

@freezed
@JsonSerializable()
class EamConditionDto with _$EamConditionDto {
  @override
  String? condition;
  @override
  String? description;

  EamConditionDto({
    this.condition,
    this.description
  });

  factory EamConditionDto.fromJson(Map<String, dynamic> json) => _$EamConditionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EamConditionDtoToJson(this);
}