import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class NumberSequenceDto {
  final String description;
  final String format;
  final int lastNumber;
  final String name;
  final String module;
  final int numberSequenceId;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  NumberSequenceDto({
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
    this.description = '',
    this.format = '',
    this.lastNumber = 0,
    this.name = '',
    this.module = '',
    this.numberSequenceId = 0
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  factory NumberSequenceDto.fromJson(Map<String, dynamic> json) => NumberSequenceDto(
    description: json['description'] as String,
    format: json['format'] as String,
    lastNumber: json['lastNumber'] as int,
    name: json['name'] as String,
    module: json['module'] as String,
    numberSequenceId: json['numberSequenceId'] as int,
    createdBy: json['createdBy'] as String,
    createdDateTime: json['createdDateTime'] as DateTime,
    modifiedBy: json['modifiedBy'] as String,
    modifiedDateTime: json['modifiedDateTime'] as DateTime
  );

  Map<String, dynamic> toJson() => {
    if (description.isNotEmpty) 'description': description,
    if (format.isNotEmpty) 'format': format,
    if (lastNumber > 0) 'lastNumber': lastNumber,
    if (name.isNotEmpty) 'name': name,
    if (module.isNotEmpty) 'module': module,
    if (numberSequenceId > 0) 'numberSequenceId': numberSequenceId,
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
  };
}
