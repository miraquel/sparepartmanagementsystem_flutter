import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:unicons/unicons.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class PurchTableLookup extends StatefulWidget {
  const PurchTableLookup({super.key});

  @override
  State<PurchTableLookup> createState() => _PurchTableLookupState();
}

class _PurchTableLookupState extends State<PurchTableLookup> {
  static const int _pageSize = 20;
  final _gmkSmsServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _logger = locator<Logger>();
  final _purchIdSearchTextController = TextEditingController();
  final _purchNameSearchTextController = TextEditingController();
  final _orderAccountSearchTextController = TextEditingController();
  final _invoiceAccountSearchTextController = TextEditingController();
  Timer? _debounce;
  bool _hideFilters = true;

  final PagingController<int, PurchTableDto> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchPage(int pageNumber) async {
    try {
      final newItems = await _gmkSmsServiceGroupDAL.getPurchTablePagedList(
        pageNumber,
        _pageSize,
        PurchTableSearchDto(
          purchId: _purchIdSearchTextController.text,
          purchName: _purchNameSearchTextController.text,
          orderAccount: _orderAccountSearchTextController.text,
          invoiceAccount: _invoiceAccountSearchTextController.text,
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
        title: const Text('Search Purchase Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Text(
              'Search for purchase orders by filters below',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _purchIdSearchTextController,
              decoration: const InputDecoration(
                labelText: 'PO Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _pagingController.refresh();
                });
              }
            ),
          ),
          Visibility(
            visible: !_hideFilters,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _purchNameSearchTextController,
                decoration: const InputDecoration(
                  labelText: 'Purch Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    _pagingController.refresh();
                  });
                }
              ),
            ),
          ),
          Visibility(
            visible: !_hideFilters,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _orderAccountSearchTextController,
                decoration: const InputDecoration(
                  labelText: 'Order Account',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    _pagingController.refresh();
                  });
                }
              ),
            ),
          ),
          Visibility(
            visible: !_hideFilters,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _invoiceAccountSearchTextController,
                decoration: const InputDecoration(
                  labelText: 'Invoice Account',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    _pagingController.refresh();
                  });
                }
              ),
            ),
          ),
          // create a clickable separator with double chevron up in the middle of the separator
          TextButton(
            onPressed: () {
              setState(() => _hideFilters = !_hideFilters);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(8.0),
              minimumSize: const Size.fromHeight(5),
              shape: const ContinuousRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: _hideFilters
                ? const Icon(UniconsLine.angle_double_down, size: 30)
                : const Icon(UniconsLine.angle_double_up, size: 30),
          ),
          Expanded(
            child: PagedListView<int, PurchTableDto>.separated(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<PurchTableDto>(
                itemBuilder: (context, item, index) => ListTile(
                  title: Text(item.purchId),
                  subtitle: Text(item.purchName),
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                ),
              ), separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
