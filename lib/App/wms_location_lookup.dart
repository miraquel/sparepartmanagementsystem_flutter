import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';

class WMSLocationLookup extends StatefulWidget {
  const WMSLocationLookup({super.key});

  @override
  State<WMSLocationLookup> createState() => _WMSLocationLookupState();
}

class _WMSLocationLookupState extends State<WMSLocationLookup> {
  static const int _pageSize = 20;
  final _wMSLocationIdSearchTextController = TextEditingController();
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  Timer? _debounce;

  final PagingController<int, WMSLocationDto> _pagingController = PagingController(firstPageKey: 1);

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
      final newItems = await _gmkSMSServiceGroupDAL.getWMSLocationPagedList(
        pageNumber,
        _pageSize,
        WMSLocationSearchDto(
          inventLocationId: Environment.userWarehouseDto.inventLocationId,
          wMSLocationId: _wMSLocationIdSearchTextController.text,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse Location Lookup'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: TextField(
              controller: _wMSLocationIdSearchTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Location',
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _pagingController.refresh();
                });
              }
            ),
          ),
          Expanded(
            child: PagedListView<int, WMSLocationDto>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<WMSLocationDto>(
                itemBuilder: (context, item, index) => ListTile(
                  title: Text(item.inventLocationId),
                  subtitle: Text(item.wMSLocationId),
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
