import '../../Model/api_response_dto.dart';
import '../../Model/goods_receipt_line_dto.dart';

abstract class GoodsReceiptLineDAL {
  Future<ApiResponseDto<List<GoodsReceiptLineDto>>> getGoodsReceiptLine();
  Future<ApiResponseDto<GoodsReceiptLineDto>> getGoodsReceiptLineById(int goodsReceiptLineId);
  Future<ApiResponseDto<GoodsReceiptLineDto>> addGoodsReceiptLine(GoodsReceiptLineDto goodsReceiptLine);
  Future<ApiResponseDto<GoodsReceiptLineDto>> updateGoodsReceiptLine(GoodsReceiptLineDto goodsReceiptLine);
  Future<ApiResponseDto<GoodsReceiptLineDto>> deleteGoodsReceiptLine(int goodsReceiptLineId);
  Future<ApiResponseDto<List<GoodsReceiptLineDto>>> getGoodsReceiptLineByParams(GoodsReceiptLineDto goodsReceiptLineDto);
}