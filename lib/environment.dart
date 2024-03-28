import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Environment {
  final _storage = const FlutterSecureStorage();
  static String _baseUrl = '';

  static String get baseUrl => _baseUrl;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _baseUrl = await _storage.read(key: 'baseUrl') ?? '';
    if (_baseUrl.isEmpty) {
      final environment = await rootBundle.loadString('environment.json');
      final config = jsonDecode(environment) as Map<String, dynamic>;
      _baseUrl = config['API_URL'] ?? '';
    }
  }

  Future<void> saveBaseUrl(String newBaseUrl) async {
    await _storage.write(key: 'baseUrl', value: newBaseUrl);
    _baseUrl = newBaseUrl;
  }

  Future<void> clearBaseUrl() async {
    await _storage.delete(key: 'baseUrl');
    final environment = await rootBundle.loadString('environment.json');
    final config = jsonDecode(environment) as Map<String, dynamic>;
    _baseUrl = config['API_URL'];
  }
}