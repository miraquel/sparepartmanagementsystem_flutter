// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
// import 'package:sparepartmanagementsystem_flutter/Model/paged_list_request_dto.dart';
// import 'package:sparepartmanagementsystem_flutter/Model/work_request_dto.dart';
// import 'package:sparepartmanagementsystem_flutter/Provider/WorkRequest/work_request_list_provider.dart';
//
// class WorkRequestList extends ConsumerWidget {
//   const WorkRequestList({super.key});
//
//   static const int pageSize = 10;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Work Request List'),
//       ),
//       body: ListView.builder(
//         itemBuilder: (BuildContext context, int index) {
//           final PagedListRequestDto pagedListRequestDto = PagedListRequestDto(
//             pageNumber: (index ~/ pageSize) + 1,
//             pageSize: pageSize,
//           );
//
//           final int indexInPage = index % pageSize;
//
//           final AsyncValue<PagedListDto<WorkRequestDto>> workRequestList = ref.watch(pagedListWorkRequestProvider(pagedListRequestDto));
//
//           return workRequestList.when(
//             data: (response) {
//               if (indexInPage >= response.items!.length) {
//                 return null;
//               }
//               final workRequest = response.items?[indexInPage];
//               return ListTile(
//                 title: Text(workRequest?.agseamwrid ?? ''),
//                 subtitle: Text(workRequest?.wrTitle ?? ''),
//                 onTap: () {
//                   Navigator.pushNamed(context, '/workRequestDetails', arguments: workRequest?.agseamwrid);
//                 },
//               );
//             },
//             loading: () => Center(child: shimmer()),
//             error: (error, stack) => Center(child: Text('Error: $error')),
//           );
//         },
//       ),
//     );
//   }
//
//   // shimmer
//   Widget shimmer() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 50,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_request_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:unicons/unicons.dart';

class WorkRequestList extends StatefulWidget {
  const WorkRequestList({super.key});

  @override
  State<WorkRequestList> createState() => _WorkRequestListState();
}

class _WorkRequestListState extends State<WorkRequestList> {
  static const _pageSize = 20;
  final _workRequestDal = locator<WorkRequestDal>();
  late NavigatorState _navigator;
  final _logger = locator<Logger>();
  final _filters = <String, String>{};

  final PagingController<int, WorkRequestDto> _pagingController = PagingController(firstPageKey: 1);

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
    ApiResponseDto<PagedListDto<WorkRequestDto>> newItems;
    try {
      var pagedListRequestDto = PagedListRequestDto(
        pageNumber: pageNumber,
        pageSize: _pageSize,
        filters: _filters.isNotEmpty ? _filters : null,
      );
      newItems = await _workRequestDal.getWorkRequestPagedList(pagedListRequestDto);
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
        title: const Text('Work Request List'),
        actions: [
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
                          decoration: const InputDecoration(
                            labelText: 'Work Request ID',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _filters['agseamwrid'] = value;
                          },
                          controller: TextEditingController(
                            text: _filters['agseamwrid'] ?? '',
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Work Request Title',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _filters['wrTitle'] = value;
                          },
                          controller: TextEditingController(
                            text: _filters['wrTitle'] ?? '',
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
                                  onPressed: () {
                                    _filters.clear();
                                    _pagingController.refresh();
                                    _navigator.pop(context);
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
        onRefresh: () async {
          return Future.sync(() => _pagingController.refresh());
        },
        child: PagedListView<int, WorkRequestDto>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<WorkRequestDto>(
            itemBuilder: (context, item, index) {
              return ListTile(
                title: Text(item.agseamwrid ?? 'No ID'),
                subtitle: Text(item.wrTitle ?? 'No Title'),
                trailing: Text(item.workflowStatus != null ? item.workflowStatus.toString() : 'No Status',
                  style: TextStyle(
                    color: item.workflowStatus == null ? Colors.grey : item.workflowStatus!.color,
                  ),
                ),
                onTap: () {
                  _navigator.pushNamed('/workRequestDetails', arguments: item.agseamwrid);
                },
              );
            },
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Text('Error loading data'),
            ),
            newPageErrorIndicatorBuilder: (context) => Center(
              child: Text('Error loading more data'),
            ),
            noItemsFoundIndicatorBuilder: (context) => Center(
              child: Text('No work requests found'),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            height: 0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
