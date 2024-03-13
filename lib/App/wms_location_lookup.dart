import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';

import '../DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import '../Model/wms_location_search_dto.dart';
import '../service_locator_setup.dart';

class WMSLocationLookup extends StatefulWidget {
  const WMSLocationLookup({super.key});

  @override
  State<WMSLocationLookup> createState() => _WMSLocationLookupState();
}

class _WMSLocationLookupState extends State<WMSLocationLookup> {
  static const int _pageSize = 20;
  final _inventLocationIdSearchTextController = TextEditingController();
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
          inventLocationId: _inventLocationIdSearchTextController.text,
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
        title: const Text('WMS Location Lookup'),
        actions: [
          IconButton(
            onPressed: () {
              buildSearchModal(context);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: TextField(
              controller: _inventLocationIdSearchTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Warehouse',
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _pagingController.refresh();
                });
              }
            ),
          ),
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

  Future<dynamic> buildSearchModal(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _inventLocationIdSearchTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Warehouse',
              ),
            ),
            TextField(
              controller: _wMSLocationIdSearchTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Location',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _pagingController.refresh();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Search')
            ),
          ].map((e) => Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 10), child: e)).toList(),
        ),
      ),
    );
  }
}
