import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class UserWarehouseDto {
  final int userWarehouseId;
  final int userId;
  final String inventLocationId;
  final String inventSiteId;
  final String name;
  final bool? isDefault;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  UserWarehouseDto({
    this.userWarehouseId = 0,
    this.userId = 0,
    this.inventLocationId = '',
    this.inventSiteId = '',
    this.name = '',
    this.isDefault = false,
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  // create another constructor named forSearch
  UserWarehouseDto.forSearch({
    this.userWarehouseId = 0,
    this.userId = 0,
    this.inventLocationId = '',
    this.inventSiteId = '',
    this.name = '',
    this.isDefault,
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;


  factory UserWarehouseDto.fromJson(Map<String, dynamic> json) {
    return UserWarehouseDto(
      userWarehouseId: json['userWarehouseId'] ?? 0,
      userId: json['userId'] ?? 0,
      inventLocationId: json['inventLocationId'] ?? '',
      inventSiteId: json['inventSiteId'] ?? '',
      name: json['name'] ?? '',
      isDefault: json['isDefault'] ?? false,
      createdBy: json['createdBy'] ?? '',
      createdDateTime: DateTime.tryParse(json['createdDateTime'] ?? '') ?? DateTimeHelper.minDateTime,
      modifiedBy: json['modifiedBy'] ?? '',
      modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] ?? '') ?? DateTimeHelper.minDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userWarehouseId != 0) 'userWarehouseId': userWarehouseId,
      if (userId != 0) 'userId': userId,
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (inventSiteId.isNotEmpty) 'inventSiteId': inventSiteId,
      if (name.isNotEmpty) 'name': name,
      if (isDefault != null) 'isDefault': isDefault,
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    };
  }

  bool compare(UserWarehouseDto other) {
    return userWarehouseId == other.userWarehouseId &&
        userId == other.userId &&
        inventLocationId == other.inventLocationId &&
        name == other.name &&
        isDefault == other.isDefault &&
        createdBy == other.createdBy &&
        createdDateTime == other.createdDateTime &&
        modifiedBy == other.modifiedBy &&
        modifiedDateTime == other.modifiedDateTime;
  }
}