import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_type_dto.freezed.dart';
part 'operation_type_dto.g.dart';

@freezed
@JsonSerializable()
class OperationTypeDto with _$OperationTypeDto {
  @override
  final int? operationTypeId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDateTime;
  @override
  final String? modifiedBy;
  @override
  final DateTime? modifiedDateTime;

  const OperationTypeDto({
    this.operationTypeId,
    this.name,
    this.description,
    this.createdBy,
    this.createdDateTime,
    this.modifiedBy,
    this.modifiedDateTime,
  });

  factory OperationTypeDto.fromJson(Map<String, dynamic> json) => _$OperationTypeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OperationTypeDtoToJson(this);
}