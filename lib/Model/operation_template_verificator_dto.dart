import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_template_verificator_dto.freezed.dart';
part 'operation_template_verificator_dto.g.dart';

@freezed
@JsonSerializable()
class OperationTemplateVerificatorDto with _$OperationTemplateVerificatorDto {
  @override
  final int? operationTemplateVerificatorId;
  @override
  final int? operationTemplateId;
  @override
  final String? name;
  @override
  final String? jobPosition;
  @override
  final String? label;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDateTime;
  @override
  final String? modifiedBy;
  @override
  final DateTime? modifiedDateTime;

  const OperationTemplateVerificatorDto({
    this.operationTemplateVerificatorId,
    this.operationTemplateId,
    this.name,
    this.jobPosition,
    this.label,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationTemplateVerificatorDto.fromJson(Map<String, dynamic> json) => _$OperationTemplateVerificatorDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationTemplateVerificatorDtoToJson(this);
}