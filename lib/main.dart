import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:sparepartmanagementsystem_flutter/App/sms_apps.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

void main() async {
  await Environment.initialize();
  serviceLocatorSetup();
  await GetIt.I.allReady();
  runApp(ProviderScope(child: const SMSApps()));
}