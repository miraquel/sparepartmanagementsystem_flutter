import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/base_model_dto.dart';

class UserWarehouseDto extends BaseModelDto {
  final int userWarehouseId;
  final int userId;
  final String inventLocationId;
  final String name;
  final bool? isDefault;

  UserWarehouseDto({
    this.userWarehouseId = 0,
    this.userId = 0,
    this.inventLocationId = '',
    this.name = '',
    this.isDefault = false,
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) : super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  // create another constructor named forSearch
  UserWarehouseDto.forSearch({
    this.userWarehouseId = 0,
    this.userId = 0,
    this.inventLocationId = '',
    this.name = '',
    this.isDefault,
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) : super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);


  factory UserWarehouseDto.fromJson(Map<String, dynamic> json) {
    return UserWarehouseDto(
      userWarehouseId: json['userWarehouseId'],
      userId: json['userId'],
      inventLocationId: json['inventLocationId'],
      name: json['name'],
      isDefault: json['isDefault'] ?? false,
      createdBy: json['createdBy'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
      modifiedBy: json['modifiedBy'],
      modifiedDateTime: DateTime.parse(json['modifiedDateTime']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (userWarehouseId != 0) 'userWarehouseId': userWarehouseId,
      if (userId != 0) 'userId': userId,
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (name.isNotEmpty) 'name': name,
      if (isDefault != null) 'isDefault': isDefault,
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime != DateTimeHelper.minDateTime) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime != DateTimeHelper.minDateTime) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
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