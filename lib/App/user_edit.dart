import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';

import '../DataAccessLayer/Abstract/user_dal.dart';
import '../DataAccessLayer/Abstract/user_warehouse_dal.dart';
import '../Model/invent_location_dto.dart';
import '../Model/user_dto.dart';
import '../Model/user_dto_builder.dart';
import '../Model/user_warehouse_dto.dart';
import '../Model/user_warehouse_dto_builder.dart';
import '../service_locator_setup.dart';

class UserEdit extends StatefulWidget {
  final int userId;
  const UserEdit({super.key, required this.userId});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> with SingleTickerProviderStateMixin {
  final _userDAL = locator<UserDAL>();
  final _userWarehouseDAL = locator<UserWarehouseDAL>();
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _formKey = GlobalKey<FormState>();
  final _userDtoBuilder = UserDtoBuilder();
  late final TabController _tabController = TabController(length: 2, vsync: this);
  late ScaffoldMessengerState _scaffoldMessengerState;
  late NavigatorState _navigatorState;
  var _isLoading = false;
  var _originalUserDto = UserDto();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessengerState = ScaffoldMessenger.of(context);
      _navigatorState = Navigator.of(context);
    });
    _getData();
  }

  Future<void> _getData() async {
    try {
      setState(() => _isLoading = true);
      var result = await _userDAL.getUserByIdWithUserWarehouse(widget.userId);
      setState(() {
        _userDtoBuilder.setFromUserDto(result.data!);
        _originalUserDto = result.data!;
        _isLoading = false;
      });
    }
    finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateUser() async {
    try {
      setState(() => _isLoading = true);
      var result = await _userDAL.updateUser(_userDtoBuilder.build());
      if (result.success) {
        _scaffoldMessengerState.showSnackBar(SnackBar(content: Text(result.message)));
      }
    }
    finally {
      setState(() => _isLoading = false);
      await _getData();
    }
  }

  Future<void> _updateUserWarehouse() async {
    try {
      setState(() => _isLoading = true);
      for (var userWarehouse in _userDtoBuilder.userWarehouses) {
        if (userWarehouse.userWarehouseId == 0) {
          userWarehouse.setUserId(_userDtoBuilder.userId);
          var result = await _userWarehouseDAL.addUserWarehouse(userWarehouse.build());
          if (result.success) {
            _scaffoldMessengerState.showSnackBar(SnackBar(content: Text(result.message)));
          }
        } else {
          var userWarehouseDto = userWarehouse.build();
          if (userWarehouseDto.compare(_originalUserDto.userWarehouses.firstWhere((element) => element.userWarehouseId == userWarehouseDto.userWarehouseId))) {
            continue;
          }
          var result = await _userWarehouseDAL.updateUserWarehouse(userWarehouseDto);
          if (result.success) {
            _scaffoldMessengerState.showSnackBar(SnackBar(content: Text(result.message)));
          }
        }
      }
    }
    finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'User Details'),
              Tab(text: 'User Warehouses')
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _userDetails(),
            _userWarehouses()
          ]
        ),
      ),
    );
  }

  Padding _userDetails() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      initialValue: _userDtoBuilder.username,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: TextEditingController(text: _userDtoBuilder.firstName),
                      decoration: const InputDecoration(
                          hintText: 'input First name',
                          labelText: 'First name'
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: TextEditingController(text: _userDtoBuilder.lastName),
                      decoration: const InputDecoration(
                          hintText: 'input Last name',
                          labelText: 'Last name'
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: TextEditingController(text: _userDtoBuilder.email),
                      decoration: const InputDecoration(
                          hintText: 'input email',
                          labelText: 'email'
                      ),
                      readOnly: true,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Is administrator'),
                      value: _userDtoBuilder.isAdministrator ?? false,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _userDtoBuilder.setIsAdministrator(value));
                        }
                      },
                      activeColor: Colors.blue,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Is enabled'),
                      value: _userDtoBuilder.isEnabled ?? false,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _userDtoBuilder.setIsEnabled(value));
                        }
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                )
              ),
            )
          ),
          ElevatedButton(
            onPressed: _updateUser,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50)
            ),
            child: const Text('Update User'),
          ),
        ],
      ),
    );
  }

  Padding _userWarehouses() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'User Warehouses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialogAddUserWarehouse(context);
            },
            child: const Text('Add User Warehouse'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _userDtoBuilder.userWarehouses.length,
              itemBuilder: (context, index) {
                var userWarehouseDtoBuilder = _userDtoBuilder.userWarehouses[index];
                return ListTile(
                  onTap: () {
                    showDialogAddUserWarehouse(context, userWarehouseDto: userWarehouseDtoBuilder.build());
                  },
                  title: Text(userWarehouseDtoBuilder.inventLocationId),
                  subtitle: Text(userWarehouseDtoBuilder.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete User Warehouse'),
                            content: const Text('Are you sure you want to delete this user warehouse?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() => _userDtoBuilder.userWarehouses.removeAt(index));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _updateUserWarehouse,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50)
            ),
            child: const Text('Update User Warehouse')
          ),
        ],
      ),
    );
  }

  showDialogAddUserWarehouse(BuildContext context, {UserWarehouseDto? userWarehouseDto}) {
    final formKey = GlobalKey<FormState>();
    final userWarehouseDtoBuilder = userWarehouseDto != null ? UserWarehouseDtoBuilder.fromUserWarehouseDto(userWarehouseDto) : UserWarehouseDtoBuilder();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Add User Warehouse'),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      DropdownSearch<InventLocationDto>(
                        selectedItem: userWarehouseDtoBuilder.inventLocationId.isNotEmpty ? InventLocationDto(inventLocationId: userWarehouseDtoBuilder.inventLocationId, name: userWarehouseDtoBuilder.name) : null,
                        validator:(value) {
                          if (value == null) {
                            return 'Please select warehouse';
                          }
                          return null;
                        },
                        popupProps: PopupPropsMultiSelection.menu(
                          isFilterOnline: true,
                          showSearchBox: true,
                          itemBuilder: (BuildContext context, InventLocationDto item, bool isSelected) {
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
                                  subtitle: Text(item.name)
                              ),
                            );
                          },
                        ),
                        asyncItems: (String searchTerm) async {
                          var searchDto = InventLocationDto(inventLocationId: searchTerm);
                          var response = await _gmkSMSServiceGroupDAL.getInventLocationList(searchDto);
                          var data = response.data?.map((e) => e).toList();
                          return data ?? [];
                        },
                        dropdownBuilder: (context, selectedItem) {
                          return selectedItem != null ? Text(selectedItem.inventLocationId) : const Text('Select Warehouse');
                        },
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Warehouse'),
                          ),
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              userWarehouseDtoBuilder.setInventLocationId(value.inventLocationId);
                              userWarehouseDtoBuilder.setName(value.name);
                            });
                          }
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: userWarehouseDtoBuilder.name),
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text('Is Default'),
                        value: userWarehouseDtoBuilder.isDefault ?? false,
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() => userWarehouseDtoBuilder.setIsDefault(value));
                          }
                        },
                        enabled: userWarehouseDto?.isDefault != true && _userDtoBuilder.userWarehouses.map((e) => e.isDefault).contains(true) ? false : true,
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (userWarehouseDto != null) {
                        var index = _userDtoBuilder.userWarehouses.indexWhere((element) => element.inventLocationId == userWarehouseDto.inventLocationId);
                        setState(() => _userDtoBuilder.userWarehouses[index] = userWarehouseDtoBuilder);
                      } else {
                        if (_userDtoBuilder.userWarehouses.map((e) => e.inventLocationId).contains(userWarehouseDtoBuilder.inventLocationId)) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Warehouse already exists in the list')));
                          Navigator.of(context).pop();
                          return;
                        }
                        setState(() => _userDtoBuilder.userWarehouses.add(userWarehouseDtoBuilder));
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }
        );
      },
    );
  }
}
