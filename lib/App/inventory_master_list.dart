
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/printer_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/scanner_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class InventoryMasterList extends StatefulWidget {
  const InventoryMasterList({super.key});

  @override
  State<InventoryMasterList> createState() => _InventoryMasterListState();
}

class _InventoryMasterListState extends State<InventoryMasterList> {
  static const _pageSize = 20;
  final _inventTableDAL = locator<GMKSMSServiceGroupDAL>();
  final _logger = locator<Logger>();
  final _itemIdSearchTextController = TextEditingController();
  final _productNameSearchTextController = TextEditingController();
  final _searchNameSearchTextController = TextEditingController();
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;
  var _isLoading = false;

  final PagingController<int, InventTableDto> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });
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
          var itemId = PrinterHelper.getItemIdFromUrl(scanData);
          await _redirectToDetails(itemId);
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
    super.dispose();
  }

  Future<void> _fetchPage(int pageNumber) async {
    ApiResponseDto<PagedListDto<InventTableDto>> newItems;
    try {
      newItems = await _inventTableDAL.getInventTablePagedList(
          pageNumber,
          _pageSize,
          InventTableSearchDto(
            itemId: _itemIdSearchTextController.text,
            productName: _productNameSearchTextController.text,
            searchName: _searchNameSearchTextController.text,
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

  Future<void> _redirectToDetails(String itemId) async {
    try {
      setState(() => _isLoading = true);
      var inventTable = await _inventTableDAL.getInventTable(itemId);
      if (inventTable.success) {
        if (inventTable.data != null) {
          _navigator.pushNamed('/inventoryMasterDetails', arguments: inventTable.data);
        } else {
          _scaffoldMessenger.showSnackBar(const SnackBar(
            content: Text('Item not found'),
          ));
        }
      }
    } catch (e) {
      _logger.e('Error while redirecting to details', error: e);
      _scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text('Error while redirecting to details, please try again later.'),
      ));
    } finally {
      if (_isLoading) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    if (barcodeScanRes == '-1') {
      return;
    }

    if (barcodeScanRes.isEmpty) {
      return;
    }

    var itemId = PrinterHelper.getItemIdFromUrl(barcodeScanRes);
    await _redirectToDetails(itemId);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inventory Master'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                buildSearchModal(context);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _scanBarcodeNormal();
          },
          child: const Icon(Icons.qr_code_scanner),
        ),
        body: PagedListView<int, InventTableDto>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<InventTableDto>(
            itemBuilder: (context, item, index) => ListTile(
              leading: item.image.isNotEmpty ?
                Hero(
                  tag: item.image,
                  child: CachedNetworkImage(
                    imageUrl: "${Environment.baseUrl}${ApiPath.getImageWithResolutionFromNetworkUri}?networkUri=${item.image}&maxLength=50",
                    width: 50,
                    height: 50,
                    fadeInDuration: const Duration(seconds: 0),
                    fadeOutDuration: const Duration(seconds: 0),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) {
                      _logger.e('Error loading image', error: error);
                      return SizedBox.fromSize(size: const Size.square(50), child: const Icon(Icons.error));
                    },
                  ),
                ) : const Image(image: AssetImage('assets/images/no_image.png'), width: 50, height: 50),
              title: Text(item.itemId),
              subtitle: Text(item.productName),
              onTap: () {
                _redirectToDetails(item.itemId);
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

  Future<dynamic> buildSearchModal(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _itemIdSearchTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item Number',
              ),
            ),
            TextField(
              controller: _productNameSearchTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Name',
              ),
            ),
            TextField(
              controller: _searchNameSearchTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search Name',
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
