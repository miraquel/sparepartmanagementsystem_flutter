import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_ax_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_ax_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkOrderAxLookup extends StatefulWidget {
  const WorkOrderAxLookup({super.key});

  @override
  State<WorkOrderAxLookup> createState() => _WorkOrderAxLookupState();
}

class _WorkOrderAxLookupState extends State<WorkOrderAxLookup> {
  static const int _pageSize = 20;
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _agseamwoidController = TextEditingController();
  Timer? _debounce;

  final PagingController<int, WorkOrderAxDto> _pagingController = PagingController(firstPageKey: 1);

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
      final newItems = await _gmkSMSServiceGroupDAL.getWorkOrderPagedList(
        pageNumber,
        _pageSize,
        WorkOrderSearchDto(
          agseamwoid: _agseamwoidController.text,
        )
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
        title: const Text('Work Order Lookup'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _agseamwoidController,
              decoration: const InputDecoration(
                labelText: 'Work Order ID',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _pagingController.refresh();
                });
              },
            ),
          ),
          Expanded(
            child: PagedListView<int, WorkOrderAxDto>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<WorkOrderAxDto>(
                itemBuilder: (context, item, index) => ListTile(
                  title: Text(item.agseamwoid),
                  subtitle: Text(item.name),
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
