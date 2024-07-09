import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';

abstract class GoodsReceiptDAL {
  Future<ApiResponseDto<List<GoodsReceiptHeaderDto>>> getGoodsReceiptHeader();
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> getGoodsReceiptHeaderById(int goodsReceiptHeaderId);
  Future<ApiResponseDto> addGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader);
  Future<ApiResponseDto> updateGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader);
  Future<ApiResponseDto> deleteGoodsReceiptHeader(int goodsReceiptHeaderId);
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderPagedList(int pageNumber, int pageSize);
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderByParamsPagedList(int pageNumber, int pageSize, GoodsReceiptHeaderDto dto);
  Future<ApiResponseDto> addGoodsReceiptHeaderWithLines(GoodsReceiptHeaderDto goodsReceiptHeader);
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> addAndReturnGoodsReceiptHeaderWithLines(GoodsReceiptHeaderDto goodsReceiptHeader);
  Future<ApiResponseDto> updateGoodsReceiptHeaderWithLines(GoodsReceiptHeaderDto goodsReceiptHeader);
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> getGoodsReceiptHeaderByIdWithLines(int goodsReceiptHeaderId);
  Future<ApiResponseDto> postToAX(GoodsReceiptHeaderDto goodsReceiptHeader);
}