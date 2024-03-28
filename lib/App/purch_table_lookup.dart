import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_search_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../Model/purch_table_dto.dart';
import '../service_locator_setup.dart';

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
        title: const Text('Purch Table Lookup'),
      ),
      body: PagedListView<int, PurchTableDto>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<PurchTableDto>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item.purchId),
            subtitle: Text(item.purchName),
            onTap: () {
              Navigator.pop(context, item);
            },
          ),
        ),
      ),
    );
  }
}
