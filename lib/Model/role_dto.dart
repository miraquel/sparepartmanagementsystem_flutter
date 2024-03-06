import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';

import '../Helper/date_time_helper.dart';
import 'base_model_dto.dart';

class RoleDto extends BaseModelDto {
  final int roleId;
  final String roleName;
  final String description;
  final List<UserDto>? users;

  RoleDto({
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
    this.roleId = 0,
    this.roleName = '',
    this.description = '',
    this.users
  }) : super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory RoleDto.fromJson(Map<String, dynamic> json) => RoleDto(
      roleId: json['roleId'] as int,
      roleName: json['roleName'] as String,
      description: json['description'] as String,
      createdBy: json['createdBy'] as String,
      createdDateTime: DateTime.parse(json['createdDateTime'] as String),
      modifiedBy: json['modifiedBy'] as String,
      modifiedDateTime: DateTime.parse(json['modifiedDateTime'] as String),
      users: json['users'] != null
          ? List<UserDto>.from(json['users'].map((e) => UserDto.fromJson(e as Map<String, dynamic>)))
          : null
  );

  @override
  Map<String, dynamic> toJson() => {
    if (roleId > 0) 'roleId': roleId,
    if (roleName.isNotEmpty) 'roleName': roleName,
    if (description.isNotEmpty) 'description': description,
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    if (users != null) 'users': users!.map((e) => e.toJson()).toList()
  };
}
