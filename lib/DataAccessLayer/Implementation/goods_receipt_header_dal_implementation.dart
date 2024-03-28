import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';

import '../../service_locator_setup.dart';
import '../api_path.dart';

class GoodsReceiptHeaderDALImplementation implements GoodsReceiptHeaderDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.post(ApiPath.addGoodsReceipt, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deleteGoodsReceiptHeader(int goodsReceiptHeaderId) async {
    final response = await _dio.delete("${ApiPath.deleteGoodsReceipt}/$goodsReceiptHeaderId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<GoodsReceiptHeaderDto>>> getGoodsReceiptHeader() async {
    final response = await _dio.get(ApiPath.getGoodsReceipt);
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
    final parameters = <String, dynamic>{};
    parameters['pageNumber'] = pageNumber;
    parameters['pageSize'] = pageSize;
    for (var entry in dto.toJson().entries) {
      if (entry.value != null && entry.value.toString().isNotEmpty) {
        parameters[entry.key] = entry.value;
      }
    }
    final response = await _dio.get(
      ApiPath.getGoodsReceiptByParamsPagedList,
      queryParameters: parameters,
    );
    return ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<GoodsReceiptHeaderDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => json.map<GoodsReceiptHeaderDto>((e) => GoodsReceiptHeaderDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderPagedList(int pageNumber, int pageSize) async {
    final parameters = <String, dynamic>{};
    parameters['pageNumber'] = pageNumber;
    parameters['pageSize'] = pageSize;
    final response = await _dio.get(
      ApiPath.getGoodsReceiptPagedList,
      queryParameters: parameters,
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
    final response = await _dio.post(ApiPath.addGoodsReceiptWithLines, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> updateGoodsReceiptHeaderWithLines(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.put(ApiPath.updateGoodsReceiptWithLines, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> getGoodsReceiptHeaderByIdWithLines(int goodsReceiptHeaderId) async {
    final response = await _dio.get("${ApiPath.getGoodsReceiptByIdWithLines}/$goodsReceiptHeaderId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(responseBody, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto> postToAX(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final response = await _dio.post(ApiPath.postToAX, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }
}
