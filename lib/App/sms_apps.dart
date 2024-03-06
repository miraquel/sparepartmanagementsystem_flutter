import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/home.dart';
import 'package:sparepartmanagementsystem_flutter/App/login.dart';
import 'package:sparepartmanagementsystem_flutter/App/purch_table_lookup.dart';
import 'package:sparepartmanagementsystem_flutter/App/role_create.dart';
import 'package:sparepartmanagementsystem_flutter/App/role_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/settings.dart';
import 'package:sparepartmanagementsystem_flutter/App/admin_center.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_create_edit.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_role.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

import '../Model/user_dto.dart';
import 'goods_receipt_header_add.dart';
import 'goods_receipt_header_list.dart';
import 'inventory_master.dart';

class SMSApps extends StatelessWidget {
  const SMSApps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SparePart Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const Home(),
        '/inventoryMaster': (context) => const InventoryMaster(),
        '/settings': (context) => const Settings(),
        '/adminCenter': (context) => const AdminCenter(),
        '/user': (context) => const UserList(),
        '/userCreate': (context) => const UserCreateEdit(),
        '/role': (context) => const RoleList(),
        '/roleCreate': (context) => const RoleCreate(),
        '/purchTableLookup': (context) => const PurchTableLookup(),
        '/goodsReceiptHeaderList': (context) => const GoodsReceiptHeaderList(),
        '/goodsReceiptHeaderAdd': (context) => const GoodsReceiptHeaderAdd(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/userEdit') {
          final args = settings.arguments as UserDto;
          return MaterialPageRoute(
            builder: (context) {
              return UserCreateEdit(
                user: args,
              );
            },
          );
        }
        if (settings.name == '/userRole') {
          final args = settings.arguments as UserDto;
          return MaterialPageRoute(
            builder: (context) {
              return UserRole(
                user: args,
              );
            },
          );
        }
        return null;
      }
    );
  }
}
