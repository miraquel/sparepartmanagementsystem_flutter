//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Environment {
  static Map<String, dynamic> config = <String, dynamic>{};

  Future<void> loadEnvironment() async {
    WidgetsFlutterBinding.ensureInitialized();
    final environment = await rootBundle.loadString('environment.json');
    config = jsonDecode(environment) as Map<String, dynamic>;
  }

  Future<String> get apiUrl async {
    const storage = FlutterSecureStorage();
    var apiUrl = await storage.read(key: 'apiUrl');
    return apiUrl ?? config['API_URL'];
  }
}