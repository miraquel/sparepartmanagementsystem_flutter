import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_entry_header_dto.freezed.dart';
part 'operation_entry_header_dto.g.dart';

@freezed
@JsonSerializable()
class OperationEntryHeaderDto with _$OperationEntryHeaderDto {
  @override
  final int? operationEntryHeaderId;
  @override
  final int? operationTemplateId;
  @override
  final String? operationEntryHeaderNumber;
  @override
  final String? description;
  @override
  final DateTime? date;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDateTime;
  @override
  final String? modifiedBy;
  @override
  final DateTime? modifiedDateTime;

  const OperationEntryHeaderDto({
    this.operationEntryHeaderId,
    this.operationTemplateId,
    this.operationEntryHeaderNumber,
    this.description,
    this.date,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationEntryHeaderDto.fromJson(Map<String, dynamic> json) => _$OperationEntryHeaderDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationEntryHeaderDtoToJson(this);
}