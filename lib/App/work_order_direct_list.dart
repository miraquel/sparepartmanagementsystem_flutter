import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkOrderDirectList extends StatefulWidget {
  const WorkOrderDirectList({super.key});

  @override
  State<WorkOrderDirectList> createState() => _WorkOrderDirectListState();
}

class _WorkOrderDirectListState extends State<WorkOrderDirectList> {
  static const _pageSize = 20;
  final _workOrderDirectDAL = locator<WorkOrderDirectDAL>();
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
      newItems = await _workOrderDirectDAL.getWorkOrderHeaderPagedList(
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
      body: RefreshIndicator(
        onRefresh: () { return Future.sync(() => _pagingController.refresh()); },
        child: PagedListView<int, WorkOrderHeaderDto>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<WorkOrderHeaderDto>(
            itemBuilder: (context, item, index) => ListTile(
              title: Text(item.agseamwoid),
              subtitle: Text(item.name),
              onTap: () {
                _navigator.pushNamed('/workOrderDirectDetails', arguments: item).then((value) => _pagingController.refresh());
              },
            ),
          ),
        ),
      ),
    );
  }
}
