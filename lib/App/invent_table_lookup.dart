import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_search_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../service_locator_setup.dart';

class InventTableLookup extends StatefulWidget {
  const InventTableLookup({super.key});

  @override
  State<InventTableLookup> createState() => _InventTableLookupState();
}

class _InventTableLookupState extends State<InventTableLookup> {
  static const int _pageSize = 20;
  final _gmkSmsServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _logger = locator<Logger>();
  final _searchTextController = TextEditingController();
  final List<String> _searchDropDownValues = ['Item Id', 'Product Name', 'Search Name'];
  String _selectedSearchDropDownValue = 'Item Id';
  Timer? _debounce;

  final PagingController<int, InventTableDto> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageNumber) async {
    try {
      final newItems = await _gmkSmsServiceGroupDAL.getRawInventTablePagedList(
        pageNumber,
        _pageSize,
        InventTableSearchDto(
          itemId: _selectedSearchDropDownValue == 'Item Id' ? _searchTextController.text : '',
          productName: _selectedSearchDropDownValue == 'Product Name' ? _searchTextController.text : '',
          searchName: _selectedSearchDropDownValue == 'Search Name' ? _searchTextController.text : '',
        ),
      );
      final isLastPage = newItems.data!.hasNextPage == false;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data!.items!);
      } else {
        final nextPageKey = newItems.data!.pageNumber + 1;
        _pagingController.appendPage(newItems.data!.items!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      _logger.e('Error fetching data', error: error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invent Table Lookup'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Combo box and a text field
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Search By',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedSearchDropDownValue,
                  items: _searchDropDownValues
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() => _selectedSearchDropDownValue = value ?? '');
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _searchTextController,
                  decoration: InputDecoration(
                    labelText: "Search text",
                    hintText: 'Enter ${_selectedSearchDropDownValue.toLowerCase()} to search',
                    border: const OutlineInputBorder()
                  ),
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      _pagingController.refresh();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PagedListView<int, InventTableDto>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<InventTableDto>(
                itemBuilder: (context, item, index) {
                  return ListTile(
                    title: Text(item.itemId),
                    subtitle: Text(item.productName),
                    onTap: () => Navigator.pop(context, item),
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
