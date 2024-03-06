import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class GoodsReceiptHeaderList extends StatefulWidget {
  const GoodsReceiptHeaderList({super.key});

  @override
  State<GoodsReceiptHeaderList> createState() => _GoodsReceiptHeaderListState();
}

class _GoodsReceiptHeaderListState extends State<GoodsReceiptHeaderList> {
  static const int _pageSize = 20;
  final GoodsReceiptHeaderDAL _goodsReceiptHeaderDAL = locator<GoodsReceiptHeaderDAL>();
  final Logger _logger = locator<Logger>();
  final _purchIdSearchTextController = TextEditingController();
  final _purchNameSearchTextController = TextEditingController();
  final PagingController<int, GoodsReceiptHeaderDto> _pagingController = PagingController(firstPageKey: 1);

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

  void _fetchPage(int pageNumber) async {
    try {
      final newItems = await _goodsReceiptHeaderDAL.getGoodsReceiptHeaderByParamsPagedList(
        pageNumber,
        _pageSize,
        GoodsReceiptHeaderDto(
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goods Receipt Header List'),
      ),
      body: PagedListView<int, GoodsReceiptHeaderDto>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<GoodsReceiptHeaderDto>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text('${item.purchId}${item.packingSlipId.isNotEmpty ? ' - ${item.packingSlipId}' : ''}'),
            subtitle: Text(item.orderAccount),
            trailing: item.submittedBy.isNotEmpty ? const Text('Submitted') : const Text('Not Submitted'),
            leadingAndTrailingTextStyle: TextStyle(fontSize: 13, color: item.submittedBy.isNotEmpty ? Colors.green : Colors.red),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/goodsReceiptHeaderAdd');
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
