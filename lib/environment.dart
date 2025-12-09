import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class Environment {
  static const _storage = FlutterSecureStorage();
  static String _baseUrl = '';
  static UserWarehouseDto _userWarehouseDto = UserWarehouseDto();
  static String _version = '';
  static const MethodChannel _zebraMethodChannel = MethodChannel('com.gandummas.sms_flutter.channel.process.data');
  static String _masterSecretKey = '';
  static bool _enableHttps = true;

  static String get baseUrl => _baseUrl;
  static UserWarehouseDto get userWarehouseDto => _userWarehouseDto;
  static String get version => _version;
  static MethodChannel get zebraMethodChannel => _zebraMethodChannel;
  static String get masterSecretKey => _masterSecretKey;
  static bool get enableHttps => _enableHttps;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _baseUrl = await _storage.read(key: 'baseUrl') ?? '';
    final enableHttpsString = await _storage.read(key: 'enableHttps');
    _enableHttps = enableHttpsString == null ? true : enableHttpsString == 'true';
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

  static Future<void> saveEnableHttps(bool enableHttps) async {
    await _storage.write(key: 'enableHttps', value: enableHttps.toString());
    _enableHttps = enableHttps;
    // Re-register Dio factory to apply the new enableHttps setting
    reregisterDio();
  }

  static Future<void> clearUserWarehouseDto() async {
    _userWarehouseDto = UserWarehouseDto();
  }
}