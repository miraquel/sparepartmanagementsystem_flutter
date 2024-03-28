import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/ActiveDirectoryDto.dart';

import '../DataAccessLayer/Abstract/user_dal.dart';
import '../Model/user_dto.dart';
import '../service_locator_setup.dart';

class UserCreateEdit extends StatefulWidget {
  final UserDto? user;
  const UserCreateEdit({super.key, this.user});

  @override
  State<UserCreateEdit> createState() => _UserCreateEditState();
}

class _UserCreateEditState extends State<UserCreateEdit> {
  final _logger = locator<Logger>();
  final _formKey = GlobalKey<FormState>();
  final _dropdownUsernameKey = GlobalKey<DropdownSearchState<String>>();
  final _userDAL = locator<UserDAL>();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;
  bool _isLoading = false;
  List<ActiveDirectoryDto> _activeDirectoryUsers = <ActiveDirectoryDto>[];
  bool _isEdit = false;

  var selectedUsername = '';
  var selectedFirstName = '';
  var selectedLastName = '';
  var selectedEmail = '';
  var selectedIsAdministrator = false;
  var selectedIsEnabled = true;
  var actions = <Widget>[];

  Future<void> saveData() async {
    try {
      setState(() => _isLoading = true);
      var user = UserDto(
          username: selectedUsername,
          firstName: selectedFirstName,
          lastName: selectedLastName,
          email: selectedEmail,
          isAdministrator: selectedIsAdministrator,
          isEnabled: selectedIsEnabled
      );
      await _userDAL.addUser(user).then((value) => _navigator.pop());
    } catch (e) {
      _logger.e('Error while saving data', error: e);
    }
    finally {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text('User $selectedUsername has been added')));
      setState(() => _isLoading = false);
    }
  }

  Future<void> editData() async {
    try {
      setState(() => _isLoading = true);
      var user = UserDto(
        userId: widget.user!.userId,
        isAdministrator: selectedIsAdministrator,
        isEnabled: selectedIsEnabled,
      );
      await _userDAL.updateUser(user);
    } catch (e) {
      _logger.e('Error while updating data', error: e);
    }
    finally {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text('User $selectedUsername has been updated')));
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _navigator = Navigator.of(context);
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });
    _isEdit = widget.user?.userId != null;

    if (_isEdit) {
      actions.add(
          IconButton(
            icon: const Icon(Icons.supervisor_account_rounded),
            onPressed: () {
              Navigator.pushNamed(context, '/userRole', arguments: widget.user);
            },
          )
      );
    }

    if (_isEdit) {
      selectedUsername = widget.user?.username ?? '';
      selectedFirstName = widget.user?.firstName ?? '';
      selectedLastName = widget.user?.lastName ?? '';
      selectedEmail = widget.user?.email ?? '';
      selectedIsAdministrator = widget.user?.isAdministrator ?? false;
      selectedIsEnabled = widget.user?.isEnabled ?? false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: !_isEdit ? const Text('User Create') : const Text('User Edit'),
          actions: actions,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                !_isEdit ? 'Add new user' : 'Edit user',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                !_isEdit ? 'Fill in the form below to add new user.' : 'Fill in the form below to edit user.',
                                style: const TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          DropdownSearch(
                            key: _dropdownUsernameKey,
                            validator:(value) {
                              if (value == null) {
                                return 'Please select username';
                              }
                              return null;
                            },
                            selectedItem: selectedUsername,
                            asyncItems: (String searchTerm) => _userDAL.getUsersFromActiveDirectory().then((value) {
                              setState(() => _activeDirectoryUsers = value.data!);
                              return _activeDirectoryUsers.map((e) => e.username).toList();
                            }),
                            enabled: !_isLoading && !_isEdit,
                            onChanged: (value) {
                              var selectedUser = _activeDirectoryUsers[_activeDirectoryUsers.indexWhere((element) => element.username == value)];
                              setState(() {
                                selectedUsername = selectedUser.username;
                                selectedFirstName = selectedUser.firstName;
                                selectedLastName = selectedUser.lastName;
                                selectedEmail = selectedUser.email;
                              });
                            },
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              fit: FlexFit.loose,
                              constraints: BoxConstraints(maxHeight: 300),
                            ),
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Username",
                                  hintText: "Select username",
                                )
                            ),
                          ),
                          TextFormField(
                            controller: TextEditingController(text: selectedFirstName),
                            enabled: false,
                            decoration: const InputDecoration(
                                hintText: 'input First name',
                                labelText: 'First name'
                            ),
                          ),
                          TextFormField(
                            controller: TextEditingController(text: selectedLastName),
                            enabled: false,
                            decoration: const InputDecoration(
                                hintText: 'input Last name',
                                labelText: 'Last name'
                            ),
                          ),
                          TextFormField(
                            controller: TextEditingController(text: selectedEmail),
                            enabled: false,
                            decoration: const InputDecoration(
                                hintText: 'input email',
                                labelText: 'email'
                            ),
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text('Is administrator'),
                            value: selectedIsAdministrator,
                            onChanged: (value) {
                              setState(() {
                                selectedIsAdministrator = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text('Is enabled'),
                            value: selectedIsEnabled,
                            onChanged: (value) {
                              setState(() {
                                selectedIsEnabled = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                        ],
                      )
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text("${!_isEdit ? "Add" : "Edit"} user $selectedUsername"),
                            content: !_isEdit ? const Text("Do you want to add this user?") : const Text("Do you want to edit this user?"),
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
                                    _navigator.pop();
                                    if (_formKey.currentState!.validate() && !_isLoading) {
                                      if (_isEdit) {
                                        await editData();
                                      }
                                      else {
                                        await saveData();
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                  child: const Text("Continue")),
                            ]
                        );
                      }
                  );
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}