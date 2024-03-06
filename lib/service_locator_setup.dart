import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/number_sequence_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/permission_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/role_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/number_sequence_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/route_observer_extension.dart';

import 'DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
import 'DataAccessLayer/Abstract/goods_receipt_line_dal.dart';
import 'DataAccessLayer/Implementation/gmk_sms_service_group_dal_implementation.dart';
import 'DataAccessLayer/Implementation/goods_receipt_header_dal_implementation.dart';
import 'DataAccessLayer/Implementation/goods_receipt_line_dal_implementation.dart';
import 'DataAccessLayer/Implementation/permission_dal_implementation.dart';
import 'DataAccessLayer/Implementation/role_dal_implementation.dart';
import 'DataAccessLayer/Implementation/user_dal_implementation.dart';
import 'dio_logging_interceptor.dart';
import 'environment.dart';

GetIt locator = GetIt.instance;
final routeObserver = RouteObserverExtension();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void serviceLocatorSetup() {
  final logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: true,
          stackTraceBeginIndex: 0
      ));
  locator.registerSingleton<Logger>(logger);
  locator.registerFactoryAsync<Dio>(() async {
    var dio = Dio();
    dio.options.baseUrl = await Environment().apiUrl;
    dio.options.connectTimeout = const Duration(seconds: 120);
    dio.options.receiveTimeout = const Duration(seconds: 120);
    dio.options.contentType = 'application/json';
    dio.interceptors.add(DioLoggingInterceptors(dio, navigatorKey: navigatorKey));
    return dio;
  });

  locator.registerFactory<GMKSMSServiceGroupDAL>(() => GMKSMSServiceGroupDALImplementation());
  locator.registerFactory<UserDAL>(() => UserDALImplementation());
  locator.registerFactory<RoleDAL>(() => RoleDALImplementation());
  locator.registerFactory<PermissionDAL>(() => PermissionDALImplementation());
  locator.registerFactory<NumberSequenceDAL>(() => NumberSequenceDALImplementation());
  locator.registerFactory<GoodsReceiptHeaderDAL>(() => GoodsReceiptHeaderDALImplementation());
  locator.registerFactory<GoodsReceiptLineDAL>(() => GoodsReceiptLineDALImplementation());
}