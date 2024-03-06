import 'package:sparepartmanagementsystem_flutter/Model/role_dto.dart';

import '../Helper/date_time_helper.dart';
import 'base_model_dto.dart';

class UserDto extends BaseModelDto {
  final int userId;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final bool? isAdministrator;
  final bool? isEnabled;
  final List<RoleDto> roles;

  UserDto({
    this.userId = 0,
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.isAdministrator,
    this.isEnabled,
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
    this.roles = const <RoleDto>[]
  }) : super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    userId: json['userId'] as int,
    username: json['username'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    isAdministrator: json['isAdministrator'] as bool?,
    isEnabled: json['isEnabled'] as bool?,
    createdBy: json['createdBy'] as String,
    createdDateTime: DateTime.parse(json['createdDateTime'] as String),
    modifiedBy: json['modifiedBy'] as String,
    modifiedDateTime: DateTime.parse(json['modifiedDateTime'] as String),
    roles: List<RoleDto>.from(json['roles'].map((e) => RoleDto.fromJson(e as Map<String, dynamic>)).toList())
  );

  @override
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
      if (roles.isNotEmpty) 'roles': roles.map((e) => e.toJson()).toList()
    };
  }
}
