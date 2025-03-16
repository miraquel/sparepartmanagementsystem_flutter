
import 'package:dio/dio.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class GoodsReceiptDALImplementation implements GoodsReceiptDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.post(ApiPath.addGoodsReceiptHeader, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deleteGoodsReceiptHeader(int goodsReceiptHeaderId) async {
    final response = await _dio.delete("${ApiPath.deleteGoodsReceiptHeader}/$goodsReceiptHeaderId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<GoodsReceiptHeaderDto>>> getGoodsReceiptHeader() async {
    final response = await _dio.get(ApiPath.getAllGoodsReceiptHeader);
    return ApiResponseDto<List<GoodsReceiptHeaderDto>>.fromJson(response.data as Map<String, dynamic>,
        (json) => json.map<GoodsReceiptHeaderDto>((e) => GoodsReceiptHeaderDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> getGoodsReceiptHeaderById(int goodsReceiptHeaderId) async {
    final response = await _dio.get("${ApiPath.getGoodsReceiptById}/$goodsReceiptHeaderId");
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(response.data as Map<String, dynamic>, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderByParamsPagedList(int pageNumber, int pageSize, GoodsReceiptHeaderDto dto) async {
    final response = await _dio.get(
      ApiPath.getGoodsReceiptHeaderByParamsPagedList,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...dto.toJson()},
    );
    return ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<GoodsReceiptHeaderDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => json.map<GoodsReceiptHeaderDto>((e) => GoodsReceiptHeaderDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderPagedList(int pageNumber, int pageSize) async {
    final response = await _dio.get(
      ApiPath.getAllGoodsReceiptHeaderPagedList,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    return ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<GoodsReceiptHeaderDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => json.map<GoodsReceiptHeaderDto>((e) => GoodsReceiptHeaderDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto> updateGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.put(ApiPath.updateGoodsReceipt, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> addGoodsReceiptHeaderWithLines(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.post(ApiPath.addGoodsReceiptHeaderWithLines, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> updateGoodsReceiptHeaderWithLines(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.put(ApiPath.updateGoodsReceiptHeaderWithLines, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> getGoodsReceiptHeaderByIdWithLines(int goodsReceiptHeaderId) async {
    final response = await _dio.get("${ApiPath.getGoodsReceiptHeaderByIdWithLines}/$goodsReceiptHeaderId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(responseBody, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto> postToAX(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.post(ApiPath.postToAX, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> addAndReturnGoodsReceiptHeaderWithLines(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.post(ApiPath.addAndReturnGoodsReceiptHeaderWithLines, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(responseBody, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<String>> getGoodsReceiptLabelTemplate(GoodsReceiptLineDto dto, int copies) async {
    final response = await _dio.get(ApiPath.getGoodsReceiptLabelTemplate, queryParameters: {...dto.toJson(), 'copies': copies});
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<String>.fromJson(responseBody, (json) => json as String);
  }
}
