import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/role_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/role_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class RoleCreate extends StatefulWidget {
  const RoleCreate({super.key});

  @override
  State<RoleCreate> createState() => _RoleCreateState();
}

class _RoleCreateState extends State<RoleCreate> {
  final _logger = locator<Logger>();
  final _roleDAL = locator<RoleDAL>();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  late NavigatorState _navigator;

  var _newRoleName = '';
  var _newRoleDescription = '';

  Future<void> saveData() async {
    setState(() => _isLoading = true);
    try {
      // sleep 5 seconds
      await Future.delayed(const Duration(seconds: 5));
      var role = RoleDto(
          roleName: _newRoleName,
          description: _newRoleDescription,
      );
      await _roleDAL.addRole(role).then((value) {
        _navigator.pop();
      });
    } catch (e) {
      _logger.e('Error while saving data', error: e);
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _navigator = Navigator.of(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Role Create'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add new role',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Fill in the form below to add new role.',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                TextFormField(
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Role Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter role name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newRoleName = value;
                    });
                  },
                ),
                TextFormField(
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newRoleDescription = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //fixedSize: const Size(150, 50),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && !_isLoading) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Add role $_newRoleName"),
                              content: const Text("Do you want to add this role?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                    child: const Text("Cancel")),
                                ElevatedButton(
                                    onPressed: () async {
                                      _navigator.pop();
                                      await saveData();
                                    },
                                    child: const Text("Continue")),
                              ],
                            );
                          });
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
