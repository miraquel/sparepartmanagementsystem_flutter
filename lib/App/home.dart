import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparepartmanagementsystem_flutter/App/status_bar.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_warehouse_dal.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:upgrader/upgrader.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final _userWarehouseDAL = locator<UserWarehouseDAL>();
  final _storage = const FlutterSecureStorage();
  late ScaffoldMessengerState _scaffoldMessenger;
  int _userId = 0;
  var _isLoading = false;

  final upgrader = Upgrader(
    //debugDisplayAlways: true,
    storeController: UpgraderStoreController(
      onAndroid: () => UpgraderAppcastStore(appcastURL: "${Environment.baseUrl}${ApiPath.getVersionFeed}"),
      oniOS: () => UpgraderAppcastStore(appcastURL: "${Environment.baseUrl}${ApiPath.getVersionFeed}"),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });

    _getDefaultUserWarehouse();
  }

  Future<void> _getDefaultUserWarehouse() async {
    try {
      setState(() => _isLoading = true);
      await _setUserId();
      var response = await _userWarehouseDAL.getDefaultUserWarehouseByUserId(_userId);
      if (response.success && response.data != null) {
        await Environment.saveUserWarehouseDto(response.data!);
      }
    }
    catch (error) {
      _scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(error.toString())
        ),
      );
    }
    finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _setUserId() async {
    try {
      var userIdString = await _storage.read(key: 'userId');
      if (userIdString == null) {
        throw Exception('User ID not found');
      }
      _userId = int.parse(userIdString);
    }
    catch (error) {
      _scaffoldMessenger.showSnackBar(
        SnackBar(
            content: Text(error.toString())
        ),
      );
    }
  }

  // List<HomeWidgetOptions> menus = [
  //   HomeWidgetOptions(
  //     'Inventory Master',
  //     20,
  //     '/inventoryMaster',
  //     Icon(
  //       UniconsLine.box,
  //       color: Colors.blue,
  //       size: 80,
  //     )
  //   ),
  //   HomeWidgetOptions(
  //     'Goods Receipt',
  //     12,
  //     '/goodsReceiptHeaderList',
  //     Icon(
  //       UniconsLine.truck_loading,
  //       color: Colors.blue,
  //       size: 35,
  //     ),
  //   ),
  //   HomeWidgetOptions(
  //     'Work Request',
  //     12,
  //     '/workRequestList',
  //     Icon(
  //       UniconsLine.bell,
  //       color: Colors.blue,
  //       size: 35,
  //     ),
  //   ),
  //   HomeWidgetOptions(
  //     'Work Order',
  //     12,
  //     '/workOrderDirectList',
  //     Icon(
  //       UniconsLine.wrench,
  //       color: Colors.blue,
  //       size: 35,
  //     ),
  //   ),
  //   // Utility Control
  //   HomeWidgetOptions(
  //     'Utility Control',
  //     12,
  //     '/operationEntryHeaderList',
  //     Icon(
  //       UniconsLine.schedule,
  //       color: Colors.blue,
  //       size: 35,
  //     ),
  //   ),
  //   // Check Equipment
  //   HomeWidgetOptions(
  //     'Check Equipment',
  //     12,
  //     '/checkEquipment',
  //     Icon(
  //       UniconsLine.check_circle,
  //       color: Colors.blue,
  //       size: 35,
  //     ),
  //   ),
  //   // Check Machine Cleaning
  //   HomeWidgetOptions(
  //     'Check Machine Cleaning',
  //     10,
  //     '/checkMachineCleaning',
  //     Icon(
  //       UniconsLine.check_circle,
  //       color: Colors.blue,
  //       size: 35,
  //     ),
  //   ),
  // ];

  List<HomeWidgetOptions> menus = [
    HomeWidgetOptions(
        'Inventory Master',
        20,
        '/inventoryMaster',
        UniconsLine.box,
    ),
    HomeWidgetOptions(
      'Goods Receipt',
      12,
      '/goodsReceiptHeaderList',
      UniconsLine.truck_loading,
    ),
    HomeWidgetOptions(
      'Work Request',
      12,
      '/workRequestList',
      UniconsLine.bell,
    ),
    HomeWidgetOptions(
      'Work Order',
      12,
      '/workOrderDirectList',
      UniconsLine.wrench,
    ),
    // Utility Control
    HomeWidgetOptions(
      'Utility Control',
      12,
      '/operationEntryHeaderCategory',
      UniconsLine.schedule,
    ),
    // Check Equipment
    HomeWidgetOptions(
      'Check Equipment',
      12,
      '/checkEquipment',
      UniconsLine.check_circle,
    ),
    // Check Machine Cleaning
    HomeWidgetOptions(
      'Check Machine Cleaning',
      10,
      '/checkMachineCleaning',
      UniconsLine.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(snackbarMessageProvider, (prev, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next)),
        );
      }
    });

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Samson Apps',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          toolbarHeight: 40,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
        body: _buildHome(context),
      ),
    );
  }

  Widget _buildHome(BuildContext context) {
    return UpgradeAlert(
        upgrader: upgrader,
        showIgnore: false,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: DropdownSearch<UserWarehouseDto>(
                      selectedItem: Environment.userWarehouseDto,
                      validator:(value) {
                        if (value == null) {
                          return 'Please select username';
                        }
                        return null;
                      },
                      compareFn: (item, selectedItem) => item == selectedItem,
                      popupProps: PopupPropsMultiSelection.menu(
                        itemBuilder: (BuildContext context, UserWarehouseDto item, bool isDisabled, bool isSelected) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              selected: isSelected,
                              dense: true,
                              title: Text(item.inventLocationId),
                              contentPadding: const EdgeInsets.all(8),
                              subtitle: Text(item.name),
                              trailing: item.isDefault != null && item.isDefault! ? const Text("Default") : null,
                            ),
                          );
                        },
                      ),
                      items: (String searchTerm, props) async {
                        var response = await _userWarehouseDAL.getUserWarehouseByUserId(_userId);
                        var data = response.data?.map((e) => e).toList();
                        return data ?? [];
                      },
                      dropdownBuilder: (context, selectedItem) {
                        return selectedItem != null ? Text("${selectedItem.inventLocationId} - ${selectedItem.name}") : const Text('Select warehouse');
                      },
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Warehouse'),
                        ),
                      ),
                      onChanged: (value) async {
                        if (value != null) {
                          await Environment.saveUserWarehouseDto(value);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double iconSize = constraints.maxWidth * 0.1; // 40% of cell width
                        double fontSize = constraints.maxWidth * 0.025; // 12% of cell width
                        double circularRadius = constraints.maxWidth * 0.03; // 20% of cell width

                        return GridView.count(
                          //physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          children: menus
                              .map((menu) =>
                              Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.pushNamed(context, menu.route);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(circularRadius),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            menu.icon,
                                            color: Colors.blue,
                                            size: iconSize,
                                          ),
                                          Flexible(
                                            child: Text(
                                              menu.title,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: fontSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // create a footer about the version of the app
            const StatusBar(),
          ],
        ),
      );
  }


}

class HomeWidgetOptions {
  final String title;
  // title font size
  final double titleFontSize;
  final String route;
  final IconData icon;

  const HomeWidgetOptions(this.title, this.titleFontSize, this.route, this.icon);
}