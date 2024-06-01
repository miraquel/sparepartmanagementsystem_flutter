import 'package:sparepartmanagementsystem_flutter/Model/role_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class UserDto {
  final int userId;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final bool? isAdministrator;
  final bool? isEnabled;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;
  final List<RoleDto> roles;
  final List<UserWarehouseDto> userWarehouses;

  UserDto({
    this.userId = 0,
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.isAdministrator,
    this.isEnabled,
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
    this.roles = const <RoleDto>[],
    this.userWarehouses = const <UserWarehouseDto>[]
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    userId: json['userId'] as int? ?? 0,
    username: json['username'] as String? ?? '',
    firstName: json['firstName'] as String? ?? '',
    lastName: json['lastName'] as String? ?? '',
    email: json['email'] as String? ?? '',
    isAdministrator: json['isAdministrator'] as bool?,
    isEnabled: json['isEnabled'] as bool?,
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    roles: json['roles'] != null ? json['roles'].map<RoleDto>((e) => RoleDto.fromJson(e)).toList() : <RoleDto>[],
    userWarehouses: json['userWarehouses'] != null ? json['userWarehouses'].map<UserWarehouseDto>((e) => UserWarehouseDto.fromJson(e)).toList() : <UserWarehouseDto>[]
  );

  Map<String, dynamic> toJson() {
    return {
      if (userId > 0) 'userId': userId,
      if (username.isNotEmpty) 'username': username,
      if (firstName.isNotEmpty) 'firstName': firstName,
      if (lastName.isNotEmpty) 'lastName': lastName,
      if (email.isNotEmpty) 'email': email,
      if (isAdministrator != null) 'isAdministrator': isAdministrator,
      if (isEnabled != null) 'isEnabled': isEnabled,
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime != DateTimeHelper.minDateTime) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime != DateTimeHelper.minDateTime) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
      if (roles.isNotEmpty) 'roles': roles.map((e) => e.toJson()).toList(),
      if (userWarehouses.isNotEmpty) 'userWarehouses': userWarehouses.map((e) => e.toJson()).toList()
    };
  }
}
