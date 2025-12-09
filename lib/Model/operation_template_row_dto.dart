import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_template_row_dto.freezed.dart';
part 'operation_template_row_dto.g.dart';

@freezed
@JsonSerializable()
class OperationTemplateRowDto with _$OperationTemplateRowDto {
  @override
  final int? operationTemplateRowId;
  @override
  final int? operationTemplateId;
  @override
  final String? rowLabel;
  @override
  final int? position;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDateTime;
  @override
  final String? modifiedBy;
  @override
  final DateTime? modifiedDateTime;

  const OperationTemplateRowDto({
    this.operationTemplateRowId,
    this.operationTemplateId,
    this.rowLabel,
    this.position,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationTemplateRowDto.fromJson(Map<String, dynamic> json) => _$OperationTemplateRowDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationTemplateRowDtoToJson(this);
}