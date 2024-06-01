import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/number_sequence_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/permission_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/role_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/row_level_access_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_warehouse_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/number_sequence_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/row_level_access_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/user_warehouse_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/gmk_sms_service_group_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/goods_receipt_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/permission_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/role_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/user_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/work_order_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Implementation/work_order_direct_dal_implementation.dart';
import 'package:sparepartmanagementsystem_flutter/dio_logging_interceptor.dart';
import 'package:sparepartmanagementsystem_flutter/route_observer_extension.dart';

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
  locator.registerFactory<Dio>(() {
    var dio = Dio();
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
  locator.registerFactory<GoodsReceiptDAL>(() => GoodsReceiptDALImplementation());
  locator.registerFactory<RowLevelAccessDAL>(() => RowLevelAccessDALImplementation());
  locator.registerFactory<WorkOrderDAL>(() => WorkOrderDALImplementation());
  locator.registerFactory<WorkOrderDirectDAL>(() => WorkOrderDirectDALImplementation());
  locator.registerFactory<UserWarehouseDAL>(() => UserWarehouseDALImplementation());
}