import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/status_bar.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_warehouse_dal.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:upgrader/upgrader.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
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
                      popupProps: PopupPropsMultiSelection.menu(
                        itemBuilder: (BuildContext context, UserWarehouseDto item, bool isSelected) {
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
                      asyncItems: (String searchTerm) async {
                        var response = await _userWarehouseDAL.getUserWarehouseByUserId(_userId);
                        var data = response.data?.map((e) => e).toList();
                        return data ?? [];
                      },
                      dropdownBuilder: (context, selectedItem) {
                        return selectedItem != null ? Text("${selectedItem.inventLocationId} - ${selectedItem.name}") : const Text('Select warehouse');
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // const Text(
                        //   'Welcome to Spare Part Management System',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(height: 5),
                        // const Text(
                        //   'Please select the menu to start',
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        // ),
                        const SizedBox(height: 15),
                        Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, '/inventoryMaster');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    UniconsLine.box,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  Text(
                                    'Inventory Master',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/goodsReceiptHeaderList');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    UniconsLine.truck_loading,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  Text(
                                    'Goods Receipt',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/workOrderDirectList');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    UniconsLine.wrench,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  Text(
                                    'Work Order',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
