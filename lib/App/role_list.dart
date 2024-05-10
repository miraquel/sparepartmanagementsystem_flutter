import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../DataAccessLayer/Abstract/role_dal.dart';
import '../Model/role_dto.dart';
import '../service_locator_setup.dart';

class RoleList extends StatefulWidget {
  const RoleList({super.key});

  @override
  State<RoleList> createState() => _RoleListState();
}

class _RoleListState extends State<RoleList> {
  final logger = locator<Logger>();
  final _roleDAL = locator<RoleDAL>();
  var _roles = <RoleDto>[];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => _isLoading = true);
    try {
      var result = await _roleDAL.getAllRole();
      setState(() => _roles = result.data!);
    } catch (e) {
      logger.e('Error while fetching data', error: e);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/roleCreate').then((value) => fetchData());
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Roles',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Role management',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              )),
          const SizedBox(height: 15),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchData,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _roles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/roleUser', arguments: _roles[index]).then((value) => fetchData());
                        },
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
                                              await _roleDAL.deleteRole(_roles[index].roleId);
                                              setState(() {
                                                _roles.removeAt(index);
                                              });
                                            } catch (e) {
                                              logger.e('Error while deleting data', error: e);
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
                        ),
                      ),
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
