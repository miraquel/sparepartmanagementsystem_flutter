import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';

class Environment {
  static const _storage = FlutterSecureStorage();
  static String _baseUrl = '';
  static UserWarehouseDto _userWarehouseDto = UserWarehouseDto();

  static String get baseUrl => _baseUrl;
  static UserWarehouseDto get userWarehouseDto => _userWarehouseDto;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _baseUrl = await _storage.read(key: 'baseUrl') ?? '';
    if (_baseUrl.isEmpty) {
      final environment = await rootBundle.loadString('environment.json');
      final config = jsonDecode(environment) as Map<String, dynamic>;
      _baseUrl = config['API_URL'] ?? '';
    }
  }

  static Future<void> saveBaseUrl(String newBaseUrl) async {
    await _storage.write(key: 'baseUrl', value: newBaseUrl);
    _baseUrl = newBaseUrl;
  }

  static Future<void> clearBaseUrl() async {
    await _storage.delete(key: 'baseUrl');
    final environment = await rootBundle.loadString('environment.json');
    final config = jsonDecode(environment) as Map<String, dynamic>;
    _baseUrl = config['API_URL'];
  }

  static Future<void> saveUserWarehouseDto(UserWarehouseDto newUserWarehouseDto) async {
    _userWarehouseDto = newUserWarehouseDto;
  }

  static Future<void> clearUserWarehouseDto() async {
    _userWarehouseDto = UserWarehouseDto();
  }
}