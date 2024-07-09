import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:unicons/unicons.dart';

class WorkOrderDirectList extends StatefulWidget {
  const WorkOrderDirectList({super.key});

  @override
  State<WorkOrderDirectList> createState() => _WorkOrderDirectListState();
}

class _WorkOrderDirectListState extends State<WorkOrderDirectList> {
  static const _pageSize = 20;
  final _workOrderDirectDAL = locator<WorkOrderDirectDAL>();
  final _agseamwoidTextController = TextEditingController();
  final _agseamwridTextController = TextEditingController();
  final _logger = locator<Logger>();
  late NavigatorState _navigator;
  var _isClosed = false;

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
          WorkOrderHeaderSearchDto(
            agseamwoid: _agseamwoidTextController.text,
            agseamwrid: _agseamwridTextController.text,
            agseamwoStatusID: _isClosed ? 'Closed' : 'Planning'
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
        actions: [
          IconButton(
            icon: Icon(_isClosed ? Icons.lock : Icons.lock_open),
            onPressed: () {
              setState(() {
                _isClosed = !_isClosed;
                _pagingController.refresh();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _agseamwoidTextController,
                          decoration: const InputDecoration(
                            labelText: 'Work Order ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: _agseamwridTextController,
                          decoration: const InputDecoration(
                            labelText: 'Work Request ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only (right: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    // make the color blue
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: _agseamwoidTextController.text.isEmpty &&
                                      _agseamwridTextController.text.isEmpty ? null : () {
                                    _agseamwoidTextController.clear();
                                    _agseamwridTextController.clear();
                                    _pagingController.refresh();
                                    Navigator.pop(context);
                                  },
                                  // child Text widget with Search text and magnifying glass icon
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Clear', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Icon(UniconsLine.trash, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    // make the color blue
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    _pagingController.refresh();
                                    Navigator.pop(context);
                                  },
                                  // child Text widget with Search text and magnifying glass icon
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Search', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Icon(UniconsLine.search, color: Colors.white, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ].map((e) => Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 10), child: e)).toList(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () { return Future.sync(() => _pagingController.refresh()); },
        child: PagedListView<int, WorkOrderHeaderDto>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<WorkOrderHeaderDto>(
            itemBuilder: (context, item, index) => ListTile(
              title: Text(item.agseamwoid),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.headerTitle),
                  Text(item.agseamEntityID),
                  Text(item.agseamPriorityID),
                  Text(item.agseamwoStatusID)
                ],
              ),
              trailing: Text(DateFormat('dd-MMM-yyyy').format(item.createdDateTime)),
              onTap: () async {
                await _navigator.pushNamed('/workOrderDirectDetails', arguments: item);
                _pagingController.refresh();
              },
            ),
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 0,
              thickness: 1,
              color: Colors.black,
            );
          },
        ),
      ),
    );
  }
}
