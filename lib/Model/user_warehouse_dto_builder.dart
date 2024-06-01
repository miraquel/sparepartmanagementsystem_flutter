import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class UserWarehouseDtoBuilder {
  int _userWarehouseId = 0;
  int _userId = 0;
  String _inventLocationId = '';
  String _inventSiteId = '';
  String _name = '';
  bool? _isDefault;
  String _createdBy = '';
  DateTime _createdDateTime = DateTimeHelper.minDateTime;
  String _modifiedBy = '';
  DateTime _modifiedDateTime = DateTimeHelper.minDateTime;

  UserWarehouseDtoBuilder();

  int get userWarehouseId => _userWarehouseId;
  int get userId => _userId;
  String get inventLocationId => _inventLocationId;
  String get inventSiteId => _inventSiteId;
  String get name => _name;
  bool? get isDefault => _isDefault;
  String get createdBy => _createdBy;
  DateTime get createdDateTime => _createdDateTime;
  String get modifiedBy => _modifiedBy;
  DateTime get modifiedDateTime => _modifiedDateTime;

  UserWarehouseDto build() {
    return UserWarehouseDto(
      userWarehouseId: _userWarehouseId,
      userId: _userId,
      inventLocationId: _inventLocationId,
      inventSiteId: _inventSiteId,
      name: _name,
      isDefault: _isDefault,
      createdBy: _createdBy,
      createdDateTime: _createdDateTime,
      modifiedBy: _modifiedBy,
      modifiedDateTime: _modifiedDateTime,
    );
  }

  factory UserWarehouseDtoBuilder.fromUserWarehouseDto(UserWarehouseDto userWarehouseDto) {
    return UserWarehouseDtoBuilder()
      .._userWarehouseId = userWarehouseDto.userWarehouseId
      .._userId = userWarehouseDto.userId
      .._inventLocationId = userWarehouseDto.inventLocationId
      .._inventSiteId = userWarehouseDto.inventSiteId
      .._name = userWarehouseDto.name
      .._isDefault = userWarehouseDto.isDefault
      .._createdBy = userWarehouseDto.createdBy
      .._createdDateTime = userWarehouseDto.createdDateTime
      .._modifiedBy = userWarehouseDto.modifiedBy
      .._modifiedDateTime = userWarehouseDto.modifiedDateTime;
  }

  UserWarehouseDtoBuilder setFromUserWarehouseDto(UserWarehouseDto userWarehouseDto) {
    _userWarehouseId = userWarehouseDto.userWarehouseId;
    _userId = userWarehouseDto.userId;
    _inventLocationId = userWarehouseDto.inventLocationId;
    _inventSiteId = userWarehouseDto.inventSiteId;
    _name = userWarehouseDto.name;
    _isDefault = userWarehouseDto.isDefault;
    _createdBy = userWarehouseDto.createdBy;
    _createdDateTime = userWarehouseDto.createdDateTime;
    _modifiedBy = userWarehouseDto.modifiedBy;
    _modifiedDateTime = userWarehouseDto.modifiedDateTime;
    return this;
  }

  UserWarehouseDtoBuilder setUserWarehouseId(int userWarehouseId) {
    _userWarehouseId = userWarehouseId;
    return this;
  }

  UserWarehouseDtoBuilder setUserId(int userId) {
    _userId = userId;
    return this;
  }

  UserWarehouseDtoBuilder setInventLocationId(String inventLocationId) {
    _inventLocationId = inventLocationId;
    return this;
  }

  UserWarehouseDtoBuilder setInventSiteId(String inventSiteId) {
    _inventSiteId = inventSiteId;
    return this;
  }

  UserWarehouseDtoBuilder setName(String name) {
    _name = name;
    return this;
  }

  UserWarehouseDtoBuilder setIsDefault(bool? isDefault) {
    _isDefault = isDefault;
    return this;
  }

  UserWarehouseDtoBuilder setCreatedBy(String createdBy) {
    _createdBy = createdBy;
    return this;
  }

  UserWarehouseDtoBuilder setCreatedDateTime(DateTime createdDateTime) {
    _createdDateTime = createdDateTime;
    return this;
  }

  UserWarehouseDtoBuilder setModifiedBy(String modifiedBy) {
    _modifiedBy = modifiedBy;
    return this;
  }

  UserWarehouseDtoBuilder setModifiedDateTime(DateTime modifiedDateTime) {
    _modifiedDateTime = modifiedDateTime;
    return this;
  }
}