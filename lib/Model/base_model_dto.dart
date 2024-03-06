abstract class BaseModelDto {
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  const BaseModelDto({
    required this.createdBy,
    required this.createdDateTime,
    required this.modifiedBy,
    required this.modifiedDateTime
  });

  Map<String, dynamic> toJson();
}