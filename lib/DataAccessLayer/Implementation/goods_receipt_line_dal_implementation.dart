import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_line_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_line_dto.dart';

import '../../service_locator_setup.dart';
import '../api_path.dart';

class GoodsReceiptLineDALImplementation implements GoodsReceiptLineDAL {
  Future<Dio> loadDio() async => await locator.getAsync<Dio>();

  @override
  Future<ApiResponseDto<GoodsReceiptLineDto>> addGoodsReceiptLine(GoodsReceiptLineDto goodsReceiptLine) async {
    final dio = await loadDio();
    final response = await dio.post(ApiPath.addGoodsReceiptLine, data: goodsReceiptLine);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<GoodsReceiptLineDto>.fromJson(responseBody, (json) => GoodsReceiptLineDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<GoodsReceiptLineDto>> deleteGoodsReceiptLine(int goodsReceiptLineId) async {
    final dio = await loadDio();
    final response = await dio.delete("${ApiPath.deleteGoodsReceiptLine}/$goodsReceiptLineId");
    return ApiResponseDto<GoodsReceiptLineDto>.fromJson(response.data as Map<String, dynamic>, (json) => GoodsReceiptLineDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<List<GoodsReceiptLineDto>>> getGoodsReceiptLine() async {
    final dio = await loadDio();
    final response = await dio.get(ApiPath.getGoodsReceiptLine);
    return ApiResponseDto<List<GoodsReceiptLineDto>>.fromJson(response.data as Map<String, dynamic>,
        (json) => List<GoodsReceiptLineDto>.from(json.map((e) => GoodsReceiptLineDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<GoodsReceiptLineDto>> getGoodsReceiptLineById(int goodsReceiptLineId) async {
    final dio = await loadDio();
    final response = await dio.get("${ApiPath.getGoodsReceiptLineById}/$goodsReceiptLineId");
    return ApiResponseDto<GoodsReceiptLineDto>.fromJson(response.data as Map<String, dynamic>, (json) => GoodsReceiptLineDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<List<GoodsReceiptLineDto>>> getGoodsReceiptLineByParams(GoodsReceiptLineDto goodsReceiptLineDto) async {
    final dio = await loadDio();
    final response = await dio.post(ApiPath.getGoodsReceiptLineByParams, data: goodsReceiptLineDto);
    return ApiResponseDto<List<GoodsReceiptLineDto>>.fromJson(response.data as Map<String, dynamic>,
        (json) => List<GoodsReceiptLineDto>.from(json.map((e) => GoodsReceiptLineDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<GoodsReceiptLineDto>> updateGoodsReceiptLine(GoodsReceiptLineDto goodsReceiptLine) async {
    final dio = await loadDio();
    final response = await dio.put(ApiPath.updateGoodsReceiptLine, data: goodsReceiptLine);
    return ApiResponseDto<GoodsReceiptLineDto>.fromJson(response.data as Map<String, dynamic>, (json) => GoodsReceiptLineDto.fromJson(json as Map<String, dynamic>));
  }
}