import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

import 'App/sms_apps.dart';
import 'environment.dart';

void main() async {
  await Environment().initialize();
  serviceLocatorSetup();
  await GetIt.I.allReady();
  runApp(const SMSApps());
}