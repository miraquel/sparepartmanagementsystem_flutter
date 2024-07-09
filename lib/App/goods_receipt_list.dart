import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:unicons/unicons.dart';

class GoodsReceiptList extends StatefulWidget {
  const GoodsReceiptList({super.key});

  @override
  State<GoodsReceiptList> createState() => _GoodsReceiptListState();
}

class _GoodsReceiptListState extends State<GoodsReceiptList> {
  static const int _pageSize = 20;
  final GoodsReceiptDAL _goodsReceiptHeaderDAL = locator<GoodsReceiptDAL>();
  final Logger _logger = locator<Logger>();
  final _purchIdSearchTextController = TextEditingController();
  final _purchNameSearchTextController = TextEditingController();
  final _orderAccountSearchTextController = TextEditingController();
  final PagingController<int, GoodsReceiptHeaderDto> _pagingController = PagingController(firstPageKey: 1);
  late ScaffoldMessengerState _scaffoldMessenger;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    // Zebra scanner device, only for Android devices
    // It is only activated when adding a new item requisition
    if (Platform.isAndroid)
    {
      Environment.zebraMethodChannel.invokeMethod("registerReceiver");
      Environment.zebraMethodChannel.setMethodCallHandler((call) async {
        if (call.method == "displayScanResult") {
          var scanData = call.arguments["scanData"];
          _purchIdSearchTextController.text = scanData;
          _pagingController.refresh();
        }
        if (call.method == "showToast") {
          _scaffoldMessenger.showSnackBar(SnackBar(
            content: Text(call.arguments as String),
          ));
        }
        return null;
      });
    }
    // end - Zebra scanner device
  }

  @override
  void dispose() {
    _pagingController.dispose();
    Environment.zebraMethodChannel.invokeMethod("unregisterReceiver");
    super.dispose();
  }

  void _fetchPage(int pageNumber) async {
    try {
      final newItems = await _goodsReceiptHeaderDAL.getGoodsReceiptHeaderByParamsPagedList(
        pageNumber,
        _pageSize,
        GoodsReceiptHeaderDto(
          purchId: _purchIdSearchTextController.text,
          purchName: _purchNameSearchTextController.text,
          orderAccount: _orderAccountSearchTextController.text,
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
      _logger.e(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goods Receipt List'),
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
                          controller: _purchIdSearchTextController,
                          decoration: const InputDecoration(
                            labelText: 'PO Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: _purchNameSearchTextController,
                          decoration: const InputDecoration(
                            labelText: 'Purch Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: _orderAccountSearchTextController,
                          decoration: const InputDecoration(
                            labelText: 'Order Account',
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
                                  onPressed: _purchIdSearchTextController.text.isEmpty &&
                                      _purchNameSearchTextController.text.isEmpty &&
                                      _orderAccountSearchTextController.text.isEmpty ? null : () {
                                    _purchIdSearchTextController.clear();
                                    _purchNameSearchTextController.clear();
                                    _orderAccountSearchTextController.clear();
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
        onRefresh: () {
          return Future.sync(() => _pagingController.refresh());
        },
        child: PagedListView<int, GoodsReceiptHeaderDto>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<GoodsReceiptHeaderDto>(
            itemBuilder: (context, item, index) => ListTile(
              title: Text(item.purchId),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.orderAccount, overflow: TextOverflow.ellipsis),
                  Text(item.purchName, overflow: TextOverflow.ellipsis),
                ],
              ),
              trailing: item.isSubmitted != null && item.isSubmitted == true ? const Text('Submitted', style: TextStyle(fontSize: 13, color: Colors.green)) : const Text('Not Submitted', style: TextStyle(fontSize: 13, color: Colors.red)),
              onTap: () {
                Navigator.pushNamed(context, '/goodsReceiptHeaderDetails', arguments: item.goodsReceiptHeaderId)
                  .then((value) => _pagingController.refresh());
              },
            ),
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/goodsReceiptHeaderAdd').then((value) => _pagingController.refresh());
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
