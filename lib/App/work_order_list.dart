import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';

import '../DataAccessLayer/Abstract/work_order_dal.dart';
import '../Model/api_response_dto.dart';
import '../Model/paged_list_dto.dart';
import '../service_locator_setup.dart';

class WorkOrderList extends StatefulWidget {
  const WorkOrderList({super.key});

  @override
  State<WorkOrderList> createState() => _WorkOrderListState();
}

class _WorkOrderListState extends State<WorkOrderList> {
  static const _pageSize = 20;
  final _workOrderDAL = locator<WorkOrderDAL>();
  final _agseamwoidTextController = TextEditingController();
  final _logger = locator<Logger>();
  late NavigatorState _navigator;

  final PagingController<int, WorkOrderHeaderDto> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });
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
    ApiResponseDto<PagedListDto<WorkOrderHeaderDto>> newItems;
    try {
      newItems = await _workOrderDAL.getWorkOrderHeaderByParamsPagedList(
          pageNumber,
          _pageSize,
          WorkOrderHeaderDto(
            agseamwoid: _agseamwoidTextController.text,
          ));
      final isLastPage = newItems.data!.hasNextPage == false;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data!.items!);
      } else {
        final nextPageKey = newItems.data!.pageNumber + 1;
        _pagingController.appendPage(newItems.data!.items!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      _logger.e('Error while fetching data', error: error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Order List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigator.pushNamed('/workOrderAdd').then((value) => _pagingController.refresh());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () { return Future.sync(() => _pagingController.refresh()); },
        child: PagedListView<int, WorkOrderHeaderDto>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<WorkOrderHeaderDto>(
            itemBuilder: (context, item, index) => ListTile(
              title: Text(item.agseamwoid),
              subtitle: Text(item.name),
              onTap: () {
                _navigator.pushNamed('/workOrderDetails', arguments: item).then((value) => _pagingController.refresh());
              },
            ),
          ),
        ),
      ),
    );
  }
}
