import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/operation_template_data_type.dart';

part 'operation_template_column_dto.freezed.dart';
part 'operation_template_column_dto.g.dart';

@freezed
@JsonSerializable()
class OperationTemplateColumnDto with _$OperationTemplateColumnDto {
  @override
  final int? operationTemplateColumnId;
  @override
  final int? operationTemplateId;
  @override
  final String? columnLabel;
  @override
  final OperationTemplateDataType? dataType;
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

  const OperationTemplateColumnDto({
    this.operationTemplateColumnId,
    this.operationTemplateId,
    this.columnLabel,
    this.dataType,
    this.position,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationTemplateColumnDto.fromJson(Map<String, dynamic> json) => _$OperationTemplateColumnDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationTemplateColumnDtoToJson(this);
}