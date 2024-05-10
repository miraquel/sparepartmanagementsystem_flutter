import 'package:flutter/material.dart';

import '../DataAccessLayer/Abstract/user_dal.dart';
import '../Model/user_dto.dart';
import '../service_locator_setup.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var users = <UserDto>[];
  late ScaffoldMessengerState scaffoldMessenger;
  late NavigatorState navigator;
  bool _isLoading = false;
  final userDAL = locator<UserDAL>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scaffoldMessenger = ScaffoldMessenger.of(context);
      navigator = Navigator.of(context);
      fetchData();
    });
  }

  Future<void> fetchData() async {
    setState(() => _isLoading = true);
    var result = await userDAL.getUser();
    setState(() {
      users = result.data!;
    });
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/userAdd').then((value) => fetchData());
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
                    'Users',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'User management',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              )
          ),
          const SizedBox(height: 15),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchData,
              child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/userEdit', arguments: users[index].userId).then((value) => fetchData());
                        },
                        title: Text(users[index].username),
                        subtitle: Text(users[index].email),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  var navigatorAlert = Navigator.of(context);
                                  return AlertDialog(
                                    title: Text("Delete user ${users[index].username}"),
                                    content: const Text("Do you want to delete this user?"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                          child: const Text("Cancel")
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await userDAL.deleteUser(users[index].userId);
                                            setState(() {
                                              users.removeAt(index);
                                            });
                                            await fetchData();
                                            navigatorAlert.pop();
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          child: const Text("Continue")),
                                    ],
                                  );
                                }
                            );
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