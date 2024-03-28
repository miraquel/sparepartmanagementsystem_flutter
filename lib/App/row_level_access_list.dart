import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';

import '../DataAccessLayer/Abstract/row_level_access_dal.dart';
import '../Model/row_level_access_dto_builder.dart';
import '../service_locator_setup.dart';

class RowLeveAccessList extends StatefulWidget {
  const RowLeveAccessList({super.key});

  @override
  State<RowLeveAccessList> createState() => _RowLeveAccessListState();
}

class _RowLeveAccessListState extends State<RowLeveAccessList> {
  final _rowLevelAccessDAL = locator<RowLevelAccessDAL>();
  final _rowLevelAccessList = <RowLevelAccessDtoBuilder>[];
  late ScaffoldMessengerState _scaffoldMessenger;
  var _isEditing = false;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });
    _fetchRowLevelAccess();
  }

  Future<void> _fetchRowLevelAccess() async {
    try {
      setState(() => _isLoading = true);
      var response = await _rowLevelAccessDAL.getRowLevelAccess();
      if (response.success) {
        setState(() {
          _rowLevelAccessList.clear();
          for (var rowLevelAccess in response.data!) {
            _rowLevelAccessList.add(RowLevelAccessDtoBuilder.fromDto(rowLevelAccess));
          }
        });
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

  Future<void> _deleteRowLevelAccesses() async {
    try {
      setState(() => _isLoading = true);
      var deletedRowLevelAccesses = _rowLevelAccessList.where((element) => element.isSelected).toList();
      var response = await _rowLevelAccessDAL.bulkDeleteRowLevelAccess(deletedRowLevelAccesses.map((e) => e.rowLevelAccessId).toList());
      if (response.success) {
        _fetchRowLevelAccess();
        _scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Row level access deleted successfully')
          ),
        );
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
          title: const Text('Row Level Access List'),
          actions: [
            if (_isEditing) ...[
              IconButton(
                onPressed: () {
                  for (var rowLevelAccess in _rowLevelAccessList) {
                    rowLevelAccess.setIsSelected(false);
                  }
                  setState(() => _isEditing = false);
                },
                icon: const Icon(Icons.cancel),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Row Level Access'),
                        content: const Text('Are you sure you want to delete the selected row level access?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteRowLevelAccesses();
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                  setState(() => _isEditing = false);
                },
              ),
            ]
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/rowLevelAccessAdd').then((value) {
              _fetchRowLevelAccess();
            });
          },
          child: const Icon(Icons.add),
        ),
        body: _rowLevelAccessList.isEmpty ?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('No items Found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('This list is currently empty.', style: TextStyle(fontSize: 15)),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: _fetchRowLevelAccess, child: const Text('Refresh')),
              ],
            ),
          ) :
          ListView.separated(
            itemCount: _rowLevelAccessList.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_rowLevelAccessList[index].userId.toString()),
                subtitle: Text(_rowLevelAccessList[index].axTable.toString()),
                trailing: Text(_rowLevelAccessList[index].query),
                leading: !_isEditing ? null : Checkbox(
                  value: _rowLevelAccessList[index].isSelected,
                  onChanged: (value) {
                    setState(() => _rowLevelAccessList[index].setIsSelected(value!));
                  },
                ),
                onTap: !_isEditing ? null : () {
                  setState(() => _rowLevelAccessList[index].setIsSelected(!_rowLevelAccessList[index].isSelected));
                },
                onLongPress: _isEditing ? null : () {
                  setState(() {
                    _isEditing = true;
                    _rowLevelAccessList[index].setIsSelected(true);
                  });
                },
              );
            },
        ),
      ),
    );
  }
}
