import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/constants/ax_table.dart';

class RowLevelAccessDto {
  final int rowLevelAccessId;
  final int userId;
  final AxTable axTable;
  final String query;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  RowLevelAccessDto({
    this.rowLevelAccessId = 0,
    this.userId = 0,
    this.axTable = AxTable.none,
    this.query = '',
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  Map<String, dynamic> toJson() {
    return {
      if (rowLevelAccessId > 0) 'RowLevelAccessId': rowLevelAccessId,
      if (userId > 0) 'UserId': userId,
      if (axTable != AxTable.none) 'AxTable': axTable.index,
      if (query.isNotEmpty) 'Query': query,
      if (createdBy.isNotEmpty) 'CreatedBy': createdBy,
      if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'CreatedDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'ModifiedBy': modifiedBy,
      if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'ModifiedDateTime': modifiedDateTime.toIso8601String(),
    };
  }

  factory RowLevelAccessDto.fromJson(Map<String, dynamic> json) {
    return RowLevelAccessDto(
      rowLevelAccessId: json['rowLevelAccessId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      axTable: AxTable.values[json['axTable'] as int? ?? 0],
      query: json['query'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      modifiedBy: json['modifiedBy'] as String? ?? '',
      modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    );
  }
}