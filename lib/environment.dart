import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';

class Environment {
  static const _storage = FlutterSecureStorage();
  static String _baseUrl = '';
  static UserWarehouseDto _userWarehouseDto = UserWarehouseDto();
  static String _version = '';
  static const MethodChannel _zebraMethodChannel = MethodChannel('com.gandummas.sms_flutter.channel.process.data');
  static String _masterSecretKey = '';

  static String get baseUrl => _baseUrl;
  static UserWarehouseDto get userWarehouseDto => _userWarehouseDto;
  static String get version => _version;
  static MethodChannel get zebraMethodChannel => _zebraMethodChannel;
  static String get masterSecretKey => _masterSecretKey;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _baseUrl = await _storage.read(key: 'baseUrl') ?? '';
    final environment = await rootBundle.loadString('environment.json');
    final config = jsonDecode(environment) as Map<String, dynamic>;
    if (_baseUrl.isEmpty) {
      _baseUrl = config['API_URL'] ?? '';
    }
    _masterSecretKey = config['MASTER_SECRET_KEY'] ?? '';
    final packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
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