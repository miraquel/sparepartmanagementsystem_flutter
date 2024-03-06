import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/goods_receipt_header_dto.dart';

abstract class GoodsReceiptHeaderDAL {
  Future<ApiResponseDto<List<GoodsReceiptHeaderDto>>> getGoodsReceiptHeader();
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> getGoodsReceiptHeaderById(int goodsReceiptHeaderId);
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> addGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader);
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> updateGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader);
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> deleteGoodsReceiptHeader(int goodsReceiptHeaderId);
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderPagedList(int pageNumber, int pageSize);
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderByParamsPagedList(int pageNumber, int pageSize, GoodsReceiptHeaderDto dto);
}