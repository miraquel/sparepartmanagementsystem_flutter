import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/shared/model/api_response.dart';
import 'package:sparepartmanagementsystem_flutter/src/shared/model/paged_list.dart';
part 'goods_receipt_service.g.dart';

@RestApi()
abstract class GoodsReceiptService {
  factory GoodsReceiptService(Dio dio) = _GoodsReceiptService;

  @GET(ApiPath.getAllGoodsReceiptHeader)
  Future<HttpResponse<ApiResponse<List<GoodsReceiptHeaderModel>>>> getGoodsReceiptHeader();

  @GET(ApiPath.getGoodsReceiptById)
  Future<HttpResponse<ApiResponse<GoodsReceiptHeaderModel>>> getGoodsReceiptHeaderById(@Path('goodsReceiptHeaderId') int goodsReceiptHeaderId);

  @POST(ApiPath.addGoodsReceiptHeader)
  Future<HttpResponse<ApiResponse>> addGoodsReceiptHeader(@Body() GoodsReceiptHeaderModel goodsReceiptHeader);

  @PUT(ApiPath.updateGoodsReceipt)
  Future<HttpResponse<ApiResponse>> updateGoodsReceiptHeader(@Body() GoodsReceiptHeaderModel goodsReceiptHeader);

  @DELETE(ApiPath.deleteGoodsReceiptHeader)
  Future<HttpResponse<ApiResponse>> deleteGoodsReceiptHeader(@Path('goodsReceiptHeaderId') int goodsReceiptHeaderId);

  @GET(ApiPath.getAllGoodsReceiptHeaderPagedList)
  Future<HttpResponse<ApiResponse<PagedList<GoodsReceiptHeaderModel>>>> getGoodsReceiptHeaderPagedList(@Query('pageNumber') int pageNumber, @Query('pageSize') int pageSize);

  @GET(ApiPath.getGoodsReceiptHeaderByParamsPagedList)
  Future<HttpResponse<ApiResponse<PagedList<GoodsReceiptHeaderModel>>>> getGoodsReceiptHeaderByParamsPagedList(@Query('pageNumber') int pageNumber, @Query('pageSize') int pageSize, @Body() GoodsReceiptHeaderModel dto);

  @POST(ApiPath.addGoodsReceiptHeaderWithLines)
  Future<HttpResponse<ApiResponse>> addGoodsReceiptHeaderWithLines(@Body() GoodsReceiptHeaderModel goodsReceiptHeader);

  @POST(ApiPath.addAndReturnGoodsReceiptHeaderWithLines)
  Future<HttpResponse<ApiResponse<GoodsReceiptHeaderModel>>> addAndReturnGoodsReceiptHeaderWithLines(@Body() GoodsReceiptHeaderModel goodsReceiptHeader);

  @PUT(ApiPath.updateGoodsReceiptHeaderWithLines)
  Future<HttpResponse<ApiResponse>> updateGoodsReceiptHeaderWithLines(@Body() GoodsReceiptHeaderModel goodsReceiptHeader);

  @GET(ApiPath.getGoodsReceiptHeaderByIdWithLines)
  Future<HttpResponse<ApiResponse<GoodsReceiptHeaderModel>>> getGoodsReceiptHeaderByIdWithLines(@Path('goodsReceiptHeaderId') int goodsReceiptHeaderId);

  @POST(ApiPath.postToAX)
  Future<HttpResponse<ApiResponse>> postToAX(@Body() GoodsReceiptHeaderModel goodsReceiptHeader);

  @GET(ApiPath.getGoodsReceiptLabelTemplate)
  Future<HttpResponse<ApiResponse<String>>> getGoodsReceiptLabelTemplate(@Query('model') GoodsReceiptHeaderModel model, @Query('copies') int copies);
}