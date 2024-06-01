import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class RoleDto {
  final int roleId;
  final String roleName;
  final String description;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;
  final List<UserDto> users;

  RoleDto({
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
    this.roleId = 0,
    this.roleName = '',
    this.description = '',
    this.users = const <UserDto>[]
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  factory RoleDto.fromJson(Map<String, dynamic> json) => RoleDto(
      roleId: json['roleId'] as int? ?? 0,
      roleName: json['roleName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      modifiedBy: json['modifiedBy'] as String? ?? '',
      modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      users: json['users'] != null ? json['users'].map<UserDto>((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList() : <UserDto>[]
  );

  Map<String, dynamic> toJson() => {
    if (roleId > 0) 'roleId': roleId,
    if (roleName.isNotEmpty) 'roleName': roleName,
    if (description.isNotEmpty) 'description': description,
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    if (users.isNotEmpty) 'users': users.map((e) => e.toJson()).toList()
  };
}
