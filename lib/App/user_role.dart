import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/role_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/role_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class UserRole extends StatefulWidget {
  final UserDto user;
  const UserRole({super.key, required this.user});

  @override
  State<UserRole> createState() => _UserRoleState();
}

class _UserRoleState extends State<UserRole> {
  final _logger = locator<Logger>();
  final _userDAL = locator<UserDAL>();
  final _roleDAL = locator<RoleDAL>();
  var _roles = <RoleDto>[];
  var _newRoles = <RoleDto>[];
  var _selectedRole = RoleDto();
  var _isLoading = false;
  late NavigatorState _navigator;

  Future<void> fetchData() async {
    setState(() => _isLoading = true);
    try {
      var result = await _userDAL.getUserByIdWithRoles(widget.user.userId);
      setState(() {
        _roles = result.data!.roles;
      });
    } catch (e) {
      _logger.e('Error while fetching data', error: e);
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _navigator = Navigator.of(context);
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Role'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.username,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Manage User Roles',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                DropdownSearch(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select role';
                    }
                    return null;
                  },
                  compareFn: (item, selectedItem) => item == selectedItem,
                  items: (String searchTerm, props) => _roleDAL.getAllRole().then((value) {
                    setState(() => _newRoles = value.data!);
                    return _newRoles.map((e) => e.roleName).toList();
                  }),
                  enabled: !_isLoading,
                  onChanged: (value) async {
                    if (value != null) {
                      setState(() {
                        _selectedRole = _newRoles.firstWhere((element) => element.roleName == value);
                      });
                    }
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                    fit: FlexFit.loose,
                    constraints: BoxConstraints(maxHeight: 300),
                  ),
                  decoratorProps: const DropDownDecoratorProps(decoration: InputDecoration(labelText: "Role", hintText: "Select role")),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Add role'),
                          content: Text('Are you sure you want to add ${_selectedRole.roleName}?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                            TextButton(
                                onPressed: () async {
                                  try {
                                    await _userDAL.addRoleToUser(widget.user.userId, _selectedRole.roleId);
                                  } catch (e) {
                                    _logger.e('Error while adding role', error: e);
                                  }
                                  await fetchData();
                                  _navigator.pop();
                                },
                                child: const Text('Continue')),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Add role'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchData,
              child: _isLoading
                  ? ListView()
                  : ListView.builder(
                itemCount: _roles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      child: ListTile(
                          title: Text(_roles[index].roleName),
                          subtitle: Text(_roles[index].description),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    var navigatorAlert = Navigator.of(context);
                                    return AlertDialog(
                                      title: Text("Delete role ${_roles[index].roleName}"),
                                      content: const Text("Do you want to delete this role?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                            child: const Text("Cancel")),
                                        ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                await _userDAL.deleteRoleFromUser(widget.user.userId, _roles[index].roleId);
                                                                                              setState(() {
                                                  _roles.removeAt(index);
                                                });
                                              } catch (e) {
                                                _logger.e('Error while deleting role', error: e);
                                              }
                                              await fetchData();
                                              navigatorAlert.pop();
                                            },
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                            child: const Text("Continue")),
                                      ],
                                    );
                                  });
                            },
                          )),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
