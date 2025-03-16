import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/active_directory_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({super.key});

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  final _userDAL = locator<UserDAL>();
  final _userDtoBuilder = UserDtoBuilder();
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;
  var _isLoading = false;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
    });
  }

  Future<void> _saveUser() async {
    setState(() => _isLoading = true);
    var response = await _userDAL.addUser(_userDtoBuilder.build());
    if (response.success) {
      _scaffoldMessenger.showSnackBar(const SnackBar(content: Text('User saved successfully')));
      _navigator.pop();
    } else {
      _scaffoldMessenger.showSnackBar(SnackBar(content: Text(response.message)));
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add User'),
        ),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: (step) => setState(() => _currentStep = step),
          onStepContinue: () => {
            if (_currentStep < 1) {
              setState(() => _currentStep += 1)
            } else {
              if (_userDtoBuilder.userWarehouses.isEmpty) {
                _scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Please add user warehouse')))
              } else if (!_userDtoBuilder.userWarehouses.map((e) => e.isDefault).contains(true)) {
                _scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Please select default warehouse')))
              }
              else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Save User'),
                      content: const Text('Are you sure you want to save this user?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _saveUser();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                )
              }
            }
          },
          onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          steps: <Step>[
            Step(
              title: _currentStep == 0 ? const Text('Add User', style: TextStyle(fontWeight: FontWeight.bold)) : const Text('Add User'),
              content: AddUserStep(userDtoBuilder: _userDtoBuilder),
            ),
            Step(
              title: _currentStep == 1 ? const Text('Add User Warehouse', style: TextStyle(fontWeight: FontWeight.bold)) : const Text('Add User Warehouse'),
              content: AddUserWarehouseStep(userDtoBuilder: _userDtoBuilder),
            ),
          ],
        ),
      ),
    );
  }
}

class AddUserStep extends StatefulWidget {
  final UserDtoBuilder userDtoBuilder;

  const AddUserStep({super.key, required this.userDtoBuilder});

  @override
  State<AddUserStep> createState() => _AddUserStepState();
}

class _AddUserStepState extends State<AddUserStep> {
  final formKey = GlobalKey<FormState>();
  final _userDAL = locator<UserDAL>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          DropdownSearch<ActiveDirectoryDto>(
            validator:(value) {
              if (value == null) {
                return 'Please select username';
              }
              return null;
            },
            popupProps: PopupPropsMultiSelection.menu(
              showSearchBox: true,
              itemBuilder: (BuildContext context, ActiveDirectoryDto item, bool isDisabled, bool isSelected) {
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
                      title: Text("${item.firstName} ${item.lastName}"),
                      contentPadding: const EdgeInsets.all(8),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.username),
                          Text(item.email),
                        ],
                      )
                  ),
                );
              },
            ),
            items: (String searchTerm, props) async {
              var response = await _userDAL.getUsersFromActiveDirectory(searchTerm);
              var data = response.data?.map((e) => e).toList();
              return data ?? [];
            },
            dropdownBuilder: (context, selectedItem) {
              return selectedItem != null ? Text(selectedItem.username) : const Text('Select User');
            },
            decoratorProps: const DropDownDecoratorProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Username'),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  widget.userDtoBuilder.setUsername(value.username);
                  widget.userDtoBuilder.setFirstName(value.firstName);
                  widget.userDtoBuilder.setLastName(value.lastName);
                  widget.userDtoBuilder.setEmail(value.email);
                });
              }
            },
            autoValidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: TextEditingController(text: widget.userDtoBuilder.firstName),
            decoration: const InputDecoration(
              hintText: 'input First name',
              labelText: 'First name',
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter first name';
              }
              return null;
            },
            readOnly: true,
          ),
          TextFormField(
            controller: TextEditingController(text: widget.userDtoBuilder.lastName),
            decoration: const InputDecoration(
              hintText: 'input Last name',
              labelText: 'Last name'
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
            readOnly: true,
          ),
          TextFormField(
            controller: TextEditingController(text: widget.userDtoBuilder.email),
            decoration: const InputDecoration(
              hintText: 'input email',
              labelText: 'email'
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
            readOnly: true,
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.all(0),
            title: const Text('Is Administrator'),
            value: widget.userDtoBuilder.isAdministrator ?? false,
            onChanged: (value) {
              if (value != null) {
                setState(() => widget.userDtoBuilder.setIsAdministrator(value));
              }
            },
            activeColor: Colors.blue,
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.all(0),
            title: const Text('Is Enabled'),
            value: widget.userDtoBuilder.isEnabled ?? false,
            onChanged: (value) {
              if (value != null) {
                setState(() => widget.userDtoBuilder.setIsEnabled(value));
              }
            },
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class AddUserWarehouseStep extends StatefulWidget {
  final UserDtoBuilder userDtoBuilder;

  const AddUserWarehouseStep({super.key, required this.userDtoBuilder});

  @override
  State<AddUserWarehouseStep> createState() => _AddUserWarehouseStepState();
}

class _AddUserWarehouseStepState extends State<AddUserWarehouseStep> {
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 270,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialogAddUserWarehouse(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50)
            ),
            child: const Text('Add User Warehouse'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.userDtoBuilder.userWarehouses.length,
              itemBuilder: (context, index) {
                var userWarehouseDto = widget.userDtoBuilder.userWarehouses[index].build();
                return ListTile(
                  onTap: () {
                    showDialogAddUserWarehouse(context, userWarehouseDto: userWarehouseDto);
                  },
                  title: Text(userWarehouseDto.inventLocationId),
                  subtitle: Text(userWarehouseDto.name),
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
                                  setState(() => widget.userDtoBuilder.userWarehouses.removeAt(index));
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
                          showSearchBox: true,
                          itemBuilder: (BuildContext context, InventLocationDto item, bool isDisabled, bool isSelected) {
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
                        items: (String searchTerm, props) async {
                          var searchDto = InventLocationDto(inventLocationId: searchTerm);
                          var response = await _gmkSMSServiceGroupDAL.getInventLocationList(searchDto);
                          var data = response.data?.map((e) => e).toList();
                          return data ?? [];
                        },
                        dropdownBuilder: (context, selectedItem) {
                          return selectedItem != null ? Text(selectedItem.inventLocationId) : const Text('Select Warehouse');
                        },
                        decoratorProps: const DropDownDecoratorProps(
                          decoration: InputDecoration(
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
                        enabled: userWarehouseDto?.isDefault != true && widget.userDtoBuilder.userWarehouses.map((e) => e.isDefault).contains(true) ? false : true,
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
                    // check if the invent location id already exists
                    // if (widget.userDtoBuilder.userWarehouses.map((e) => e.inventLocationId).contains(userWarehouseDtoBuilder.inventLocationId)) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Warehouse already exists in the list')));
                    //   Navigator.of(context).pop();
                    //   return;
                    // }
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (userWarehouseDto != null) {
                        var index = widget.userDtoBuilder.userWarehouses.indexWhere((element) => element.inventLocationId == userWarehouseDto.inventLocationId);
                        setState(() => widget.userDtoBuilder.userWarehouses[index] = userWarehouseDtoBuilder);
                      } else {
                        if (widget.userDtoBuilder.userWarehouses.map((e) => e.inventLocationId).contains(userWarehouseDtoBuilder.inventLocationId)) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Warehouse already exists in the list')));
                          Navigator.of(context).pop();
                          return;
                        }
                        setState(() => widget.userDtoBuilder.userWarehouses.add(userWarehouseDtoBuilder));
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

