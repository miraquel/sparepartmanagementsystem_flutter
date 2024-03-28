import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/goods_receipt_line_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/home.dart';
import 'package:sparepartmanagementsystem_flutter/App/inventory_master_details.dart';
import 'package:sparepartmanagementsystem_flutter/App/inventory_master_stock_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/login.dart';
import 'package:sparepartmanagementsystem_flutter/App/purch_table_lookup.dart';
import 'package:sparepartmanagementsystem_flutter/App/role_create.dart';
import 'package:sparepartmanagementsystem_flutter/App/role_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/row_level_access_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/row_level_access_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/settings.dart';
import 'package:sparepartmanagementsystem_flutter/App/admin_center.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_create_edit.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_role.dart';
import 'package:sparepartmanagementsystem_flutter/App/wms_location_lookup.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

import '../Model/user_dto.dart';
import 'fullscreen_image_viewer.dart';
import 'goods_receipt_add.dart';
import 'goods_receipt_details.dart';
import 'goods_receipt_list.dart';
import 'inventory_master_list.dart';

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
        '/inventoryMaster': (context) => const InventoryMasterList(),
        '/settings': (context) => const Settings(),
        '/adminCenter': (context) => const AdminCenter(),
        '/user': (context) => const UserList(),
        '/userCreate': (context) => const UserCreateEdit(),
        '/role': (context) => const RoleList(),
        '/roleCreate': (context) => const RoleCreate(),
        '/purchTableLookup': (context) => const PurchTableLookup(),
        '/goodsReceiptHeaderList': (context) => const GoodsReceiptList(),
        '/goodsReceiptHeaderAdd': (context) => const GoodsReceiptAdd(),
        '/wMSLocationLookup': (context) => const WMSLocationLookup(),
        '/rowLevelAccessList': (context) => const RowLeveAccessList(),
        '/rowLevelAccessAdd': (context) => const RowLevelAccessAdd(),
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
        if (settings.name == '/goodsReceiptHeaderDetails') {
          final args = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return GoodsReceiptDetails(
                goodsReceiptHeaderId: args,
              );
            },
          );
        }
        if (settings.name == '/goodsReceiptLineAdd') {
          final args = settings.arguments as GoodsReceiptHeaderDto;
          return MaterialPageRoute(
            builder: (context) {
              return GoodsReceiptLineAdd(
                goodsReceiptHeader: args,
              );
            },
          );
        }
        if (settings.name == '/inventoryMasterDetails') {
        final args = settings.arguments as InventTableDto;
          return MaterialPageRoute(
            builder: (context) {
              return InventoryMasterDetails(
                inventTableDto: args,
              );
            },
          );
        }
        if (settings.name == '/fullScreenImageViewer') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return FullscreenImageViewer(
                imageNetworkPath: args['imageNetworkPath'],
                errorHandler: args['errorHandler'],
              );
            },
          );
        }
        if (settings.name == '/inventoryMasterStockList')
        {
          final args = settings.arguments as InventTableDto;
          return MaterialPageRoute(
            builder: (context) {
              return InventoryMasterStockList(
                inventTableDto: args,
              );
            },
          );
        }
        return null;
      }
    );
  }
}
