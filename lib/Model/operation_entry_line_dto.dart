import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_column_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_row_dto.dart';

part 'operation_entry_line_dto.freezed.dart';
part 'operation_entry_line_dto.g.dart';

@freezed
@JsonSerializable()
class OperationEntryLineDto with _$OperationEntryLineDto {
  @override
  final int operationEntryLineId;
  @override
  final int operationEntryHeaderId;
  @override
  final int operationTemplateRowId;
  @override
  final int operationTemplateColumnId;
  @override
  final String? value;
  @override
  final OperationTemplateRowDto? operationTemplateRow;
  @override
  final OperationTemplateColumnDto? operationTemplateColumn;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDateTime;
  @override
  final String? modifiedBy;
  @override
  final DateTime? modifiedDateTime;

  const OperationEntryLineDto({
    required this.operationEntryLineId,
    required this.operationEntryHeaderId,
    required this.operationTemplateRowId,
    required this.operationTemplateColumnId,
    this.value,
    this.operationTemplateRow,
    this.operationTemplateColumn,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationEntryLineDto.fromJson(Map<String, dynamic> json) => _$OperationEntryLineDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationEntryLineDtoToJson(this);
}