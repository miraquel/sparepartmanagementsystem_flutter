import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_template_dto.freezed.dart';
part 'operation_template_dto.g.dart';

@freezed
@JsonSerializable()
class OperationTemplateDto with _$OperationTemplateDto {
  @override
  final int? operationTemplateId;
  @override
  final int? operationTypeId;
  @override
  final String? name;
  @override
  final String? documentNo;
  @override
  final String? revision;
  @override
  final DateTime? effectiveDate;
  @override
  final String? description;
  @override
  final String? documentRetentionPeriod;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDateTime;
  @override
  final String? modifiedBy;
  @override
  final DateTime? modifiedDateTime;

  const OperationTemplateDto({
    this.operationTemplateId,
    this.operationTypeId,
    this.name,
    this.documentNo,
    this.revision,
    this.effectiveDate,
    this.description,
    this.documentRetentionPeriod,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationTemplateDto.fromJson(Map<String, dynamic> json) => _$OperationTemplateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationTemplateDtoToJson(this);
}