import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_entry_verification_dto.freezed.dart';
part 'operation_entry_verification_dto.g.dart';

@freezed
@JsonSerializable()
class OperationEntryVerificationDto with _$OperationEntryVerificationDto {
  @override
  final int operationEntryVerificationId;
  @override
  final int operationEntryHeaderId;
  @override
  final int operationTemplateVerificatorId;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDateTime;
  @override
  final String? modifiedBy;
  @override
  final DateTime? modifiedDateTime;

  const OperationEntryVerificationDto({
    required this.operationEntryVerificationId,
    required this.operationEntryHeaderId,
    required this.operationTemplateVerificatorId,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationEntryVerificationDto.fromJson(Map<String, dynamic> json) => _$OperationEntryVerificationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationEntryVerificationDtoToJson(this);
}