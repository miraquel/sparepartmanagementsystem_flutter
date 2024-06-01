import 'package:sparepartmanagementsystem_flutter/Model/role_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class UserDtoBuilder {
  int _userId = 0;
  String _username = '';
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  bool? _isAdministrator;
  bool? _isEnabled;
  String _createdBy = '';
  DateTime _createdDateTime = DateTimeHelper.minDateTime;
  String _modifiedBy = '';
  DateTime _modifiedDateTime = DateTimeHelper.minDateTime;
  List<RoleDto> _roles = <RoleDto>[];
  List<UserWarehouseDtoBuilder> _userWarehouses = <UserWarehouseDtoBuilder>[];

  int get userId => _userId;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  bool? get isAdministrator => _isAdministrator;
  bool? get isEnabled => _isEnabled;
  String get createdBy => _createdBy;
  DateTime get createdDateTime => _createdDateTime;
  String get modifiedBy => _modifiedBy;
  DateTime get modifiedDateTime => _modifiedDateTime;
  List<RoleDto> get roles => _roles;
  List<UserWarehouseDtoBuilder> get userWarehouses => _userWarehouses;

  UserDtoBuilder();

  UserDto build() {
    return UserDto(
      userId: _userId,
      username: _username,
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      isAdministrator: _isAdministrator,
      isEnabled: _isEnabled,
      createdBy: _createdBy,
      createdDateTime: _createdDateTime,
      modifiedBy: _modifiedBy,
      modifiedDateTime: _modifiedDateTime,
      roles: _roles,
      userWarehouses: _userWarehouses.map((e) => e.build()).toList(),
    );
  }

  factory UserDtoBuilder.fromUserDto(UserDto userDto) {
    return UserDtoBuilder()
      .._userId = userDto.userId
      .._username = userDto.username
      .._firstName = userDto.firstName
      .._lastName = userDto.lastName
      .._email = userDto.email
      .._isAdministrator = userDto.isAdministrator
      .._isEnabled = userDto.isEnabled
      .._createdBy = userDto.createdBy
      .._createdDateTime = userDto.createdDateTime
      .._modifiedBy = userDto.modifiedBy
      .._modifiedDateTime = userDto.modifiedDateTime
      .._roles = userDto.roles
      .._userWarehouses = userDto.userWarehouses.map((e) => UserWarehouseDtoBuilder.fromUserWarehouseDto(e)).toList();
  }

  UserDtoBuilder setFromUserDto(UserDto userDto) {
    _userId = userDto.userId;
    _username = userDto.username;
    _firstName = userDto.firstName;
    _lastName = userDto.lastName;
    _email = userDto.email;
    _isAdministrator = userDto.isAdministrator;
    _isEnabled = userDto.isEnabled;
    _createdBy = userDto.createdBy;
    _createdDateTime = userDto.createdDateTime;
    _modifiedBy = userDto.modifiedBy;
    _modifiedDateTime = userDto.modifiedDateTime;
    _roles = userDto.roles;
    _userWarehouses = userDto.userWarehouses.map((e) => UserWarehouseDtoBuilder.fromUserWarehouseDto(e)).toList();
    return this;
  }

  UserDtoBuilder setUserId(int userId) {
    _userId = userId;
    return this;
  }

  UserDtoBuilder setUsername(String username) {
    _username = username;
    return this;
  }

  UserDtoBuilder setFirstName(String firstName) {
    _firstName = firstName;
    return this;
  }

  UserDtoBuilder setLastName(String lastName) {
    _lastName = lastName;
    return this;
  }

  UserDtoBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserDtoBuilder setIsAdministrator(bool isAdministrator) {
    _isAdministrator = isAdministrator;
    return this;
  }

  UserDtoBuilder setIsEnabled(bool isEnabled) {
    _isEnabled = isEnabled;
    return this;
  }

  UserDtoBuilder setCreatedBy(String createdBy) {
    _createdBy = createdBy;
    return this;
  }

  UserDtoBuilder setCreatedDateTime(DateTime createdDateTime) {
    _createdDateTime = createdDateTime;
    return this;
  }

  UserDtoBuilder setModifiedBy(String modifiedBy) {
    _modifiedBy = modifiedBy;
    return this;
  }

  UserDtoBuilder setModifiedDateTime(DateTime modifiedDateTime) {
    _modifiedDateTime = modifiedDateTime;
    return this;
  }

  UserDtoBuilder setRoles(List<RoleDto> roles) {
    _roles = roles;
    return this;
  }

  UserDtoBuilder setUserWarehouses(List<UserWarehouseDtoBuilder> userWarehouses) {
    _userWarehouses = userWarehouses;
    return this;
  }
}