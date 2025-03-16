import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/row_level_access_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/constants/ax_table.dart';
import 'package:sparepartmanagementsystem_flutter/Model/row_level_access_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class RowLevelAccessAdd extends StatefulWidget {
  const RowLevelAccessAdd({super.key});

  @override
  State<RowLevelAccessAdd> createState() => _RowLevelAccessAddState();
}

class _RowLevelAccessAddState extends State<RowLevelAccessAdd> {
  final _rowLevelAccessDAL = locator<RowLevelAccessDAL>();
  final _userDAL = locator<UserDAL>();
  final _rowLevelAccess = RowLevelAccessDtoBuilder();
  final _formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState _scaffoldMessenger;
  late NavigatorState _navigator;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
      _navigator = Navigator.of(context);
    });
  }

  Future<void> _saveRowLevelAccess() async {
    try {
      setState(() => _isLoading = true);
      var response = await _rowLevelAccessDAL.addRowLevelAccess(_rowLevelAccess.build());
      if (response.success) {
        _scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Row level access added successfully')
          ),
        );
        _navigator.pop();
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

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Row Level Access'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text('Add Row Level Access', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text('Please fill in the form below to add a new row level access.', style: TextStyle(fontSize: 15)),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownSearch(
                            validator:(value) {
                              if (value == null) {
                                return 'Please select username';
                              }
                              return null;
                            },
                            compareFn: (item, selectedItem) => item == selectedItem,
                            popupProps: PopupPropsMultiSelection.menu(
                              showSearchBox: true,
                              itemBuilder: (BuildContext context, dynamic item, bool isDisabled, bool isSelected) {
                                var activeDirectory = item as UserDto;
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
                                    title: Text("${activeDirectory.firstName} ${activeDirectory.lastName}"),
                                    contentPadding: const EdgeInsets.all(8),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(activeDirectory.username),
                                        Text(activeDirectory.email),
                                      ],
                                    )
                                  ),
                                );
                              },
                            ),
                            items: (String searchTerm, props) async {
                              var response = await _userDAL.getUser();
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
                            enabled: !_isLoading,
                            onChanged: (value) {
                              value as UserDto;
                              _rowLevelAccess.setUserId(value.userId);
                            },
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'AX Table',
                          ),
                          isDense: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          onChanged: (value) => _rowLevelAccess.setAxTable(AxTable.values[int.parse(value ?? '0')]),
                          items: AxTable.values.map((e) => DropdownMenuItem(value: e.index.toString(), child: Text(e.toString(), style: const TextStyle(fontSize: 14)))).toList(),
                          hint: const Text('Select Ax Table'),
                          value: _rowLevelAccess.axTable.index.toString(),
                          validator: (value) {
                            if (AxTable.values[int.parse(value ?? '0')] == AxTable.none) {
                              return 'Please select AX Table';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            onChanged: (value) => _rowLevelAccess.setQuery(value),
                            decoration: const InputDecoration(
                              labelText: 'Query',
                              hintText: 'Fill in Query',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please fill in query';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _saveRowLevelAccess();
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
