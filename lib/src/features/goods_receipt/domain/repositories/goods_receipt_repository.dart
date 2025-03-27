import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/shared/model/paged_list.dart';

abstract class GoodsReceiptRepository {
  Future<DataState<List<GoodsReceiptHeaderModel>>> getGoodsReceiptHeader();
  
  Future<DataState<GoodsReceiptHeaderModel>> getGoodsReceiptHeaderById(int goodsReceiptHeaderId);
  
  Future<DataState<String>> addGoodsReceiptHeader(GoodsReceiptHeaderModel goodsReceiptHeader);
  
  Future<DataState<String>> updateGoodsReceiptHeader(GoodsReceiptHeaderModel goodsReceiptHeader);
  
  Future<DataState<String>> deleteGoodsReceiptHeader(int goodsReceiptHeaderId);
  
  Future<DataState<PagedList<GoodsReceiptHeaderModel>>> getGoodsReceiptHeaderPagedList(
    int pageNumber, 
    int pageSize
  );
  
  Future<DataState<PagedList<GoodsReceiptHeaderModel>>> getGoodsReceiptHeaderByParamsPagedList(
    int pageNumber, 
    int pageSize, 
    GoodsReceiptHeaderModel dto
  );
  
  Future<DataState<String>> addGoodsReceiptHeaderWithLines(GoodsReceiptHeaderModel goodsReceiptHeader);
  
  Future<DataState<GoodsReceiptHeaderModel>> addAndReturnGoodsReceiptHeaderWithLines(
    GoodsReceiptHeaderModel goodsReceiptHeader
  );
  
  Future<DataState<String>> updateGoodsReceiptHeaderWithLines(GoodsReceiptHeaderModel goodsReceiptHeader);
  
  Future<DataState<GoodsReceiptHeaderModel>> getGoodsReceiptHeaderByIdWithLines(int goodsReceiptHeaderId);
  
  Future<DataState<String>> postToAX(GoodsReceiptHeaderModel goodsReceiptHeader);
  
  Future<DataState<String>> getGoodsReceiptLabelTemplate(
    GoodsReceiptHeaderModel model, 
    int copies
  );
}