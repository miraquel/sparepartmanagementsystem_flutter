import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/MobileScanner/barcode_scanner_with_scan_window.dart';

import 'package:sparepartmanagementsystem_flutter/App/goods_receipt_line_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/home.dart';
import 'package:sparepartmanagementsystem_flutter/App/invent_table_lookup.dart';
import 'package:sparepartmanagementsystem_flutter/App/inventory_master_details.dart';
import 'package:sparepartmanagementsystem_flutter/App/inventory_master_stock_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/item_requisition_direct_add_location.dart';
import 'package:sparepartmanagementsystem_flutter/App/login.dart';
import 'package:sparepartmanagementsystem_flutter/App/printer_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/purch_table_lookup.dart';
import 'package:sparepartmanagementsystem_flutter/App/role_create.dart';
import 'package:sparepartmanagementsystem_flutter/App/role_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/row_level_access_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/row_level_access_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/settings.dart';
import 'package:sparepartmanagementsystem_flutter/App/admin_center.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_edit.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_role.dart';
import 'package:sparepartmanagementsystem_flutter/App/user_warehouse_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/wms_location_lookup.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_details.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_direct_details.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_direct_line_details.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_direct_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_line_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/work_order_ax_lookup.dart';
import 'package:sparepartmanagementsystem_flutter/App/fullscreen_image_viewer.dart';
import 'package:sparepartmanagementsystem_flutter/App/goods_receipt_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/goods_receipt_details.dart';
import 'package:sparepartmanagementsystem_flutter/App/goods_receipt_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/inventory_master_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/item_requisition_add.dart';
import 'package:sparepartmanagementsystem_flutter/App/item_requisition_direct_details.dart';
import 'package:sparepartmanagementsystem_flutter/App/item_requisition_direct_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/item_requisition_list.dart';
import 'package:sparepartmanagementsystem_flutter/App/zebra_scanner_settings.dart';
import 'package:sparepartmanagementsystem_flutter/App/zebra_scanner_test.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';

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
        //'/userCreate': (context) => const UserCreateEdit(),
        '/userAdd': (context) => const UserAdd(),
        '/role': (context) => const RoleList(),
        '/roleCreate': (context) => const RoleCreate(),
        '/purchTableLookup': (context) => const PurchTableLookup(),
        '/goodsReceiptHeaderList': (context) => const GoodsReceiptList(),
        '/goodsReceiptHeaderAdd': (context) => const GoodsReceiptAdd(),
        '/wMSLocationLookup': (context) => const WMSLocationLookup(),
        '/rowLevelAccessList': (context) => const RowLeveAccessList(),
        '/rowLevelAccessAdd': (context) => const RowLevelAccessAdd(),
        '/workOrderList': (context) => const WorkOrderList(),
        '/workOrderDirectList': (context) => const WorkOrderDirectList(),
        '/workOrderAdd': (context) => const WorkOrderAdd(),
        '/workOrderLookup': (context) => const WorkOrderAxLookup(),
        '/workOrderLineAdd': (context) => const WorkOrderLineAdd(),
        '/itemRequisitionAdd': (context) => const ItemRequisitionAdd(),
        '/inventTableLookup': (context) => const InventTableLookup(),
        '/zebraScannerSettings': (context) => const ZebraScannerSettings(),
        '/zebraScannerTest': (context) => const ZebraScannerTest(),
        '/printerList': (context) => const PrinterList(),
        '/mobileScanner':(context) => const BarcodeScannerWithScanWindow(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/userEdit') {
          final args = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return UserEdit(
                userId: args,
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
          // check the type of the settings.arguments
          if (settings.arguments is int) {
            final goodsReceiptHeaderId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) {
                return GoodsReceiptDetails(
                  goodsReceiptHeaderId: goodsReceiptHeaderId,
                );
              },
            );
          } else {
            final goodsReceiptHeaderDto = settings.arguments as GoodsReceiptHeaderDto;
            return MaterialPageRoute(
              builder: (context) {
                return GoodsReceiptDetails(
                  goodsReceiptHeaderDto: goodsReceiptHeaderDto,
                );
              },
            );
          }
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
        if (settings.name == '/workOrderDetails')
        {
          final args = settings.arguments as WorkOrderHeaderDto;
          return MaterialPageRoute(
            builder: (context) {
              return WorkOrderDetails(
                workOrderHeaderDto: args,
              );
            },
          );
        }
        if (settings.name == '/workOrderDirectDetails')
        {
          final args = settings.arguments as WorkOrderHeaderDto;
          return MaterialPageRoute(
            builder: (context) {
              return WorkOrderDirectDetails(
                workOrderHeaderDto: args,
              );
            },
          );
        }
        if (settings.name == '/itemRequisitionList')
        {
          final args = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return ItemRequisitionList(
                workOrderLineId: args,
              );
            },
          );
        }
        if (settings.name == '/itemRequisitionDirectList')
        {
          final args = settings.arguments as WorkOrderLineDto;
          return MaterialPageRoute(
            builder: (context) {
              return ItemRequisitionDirectList(
                workOrderLineDto: args,
              );
            },
          );
        }
        if (settings.name == '/userWarehouseList')
        {
          final args = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return UserWarehouseList(
                userId: args,
              );
            },
          );
        }
        if (settings.name == '/itemRequisitionDirectDetails')
        {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ItemRequisitionDirectDetails(
                workOrderLineDto: args['workOrderLineDto'],
                inventReqDto: args['inventReqDto'],
              );
            },
          );
        }
        if (settings.name == '/itemRequisitionDirectAddLocation')
        {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return ItemRequisitionDirectAddLocation(
                itemId: args,
              );
            },
          );
        }
        // await _navigator.pushNamed('/itemRequisitionDirectList', arguments: workOrderLine.build());
        if (settings.name == '/workOrderDirectLineDetails')
        {
          final args = settings.arguments as WorkOrderLineDto;
          return MaterialPageRoute(
            builder: (context) {
              return WorkOrderDirectLineDetails(
                workOrderLineDto: args,
              );
            },
          );
        }
        return null;
      }
    );
  }
}
