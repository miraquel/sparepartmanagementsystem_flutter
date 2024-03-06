import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/goods_receipt_header_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';

import '../../service_locator_setup.dart';
import '../api_path.dart';

class GoodsReceiptHeaderDALImplementation implements GoodsReceiptHeaderDAL {
  Future<Dio> loadDio() async => await locator.getAsync<Dio>();

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> addGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final dio = await loadDio();
    final response = await dio.post(ApiPath.addGoodsReceiptHeader, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(responseBody, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> deleteGoodsReceiptHeader(int goodsReceiptHeaderId) async {
    final dio = await loadDio();
    final response = await dio.delete("${ApiPath.deleteGoodsReceiptHeader}/$goodsReceiptHeaderId");
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(response.data as Map<String, dynamic>, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<List<GoodsReceiptHeaderDto>>> getGoodsReceiptHeader() async {
    final dio = await loadDio();
    final response = await dio.get(ApiPath.getGoodsReceiptHeader);
    return ApiResponseDto<List<GoodsReceiptHeaderDto>>.fromJson(response.data as Map<String, dynamic>,
        (json) => List<GoodsReceiptHeaderDto>.from(json.map((e) => GoodsReceiptHeaderDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> getGoodsReceiptHeaderById(int goodsReceiptHeaderId) async {
    final dio = await loadDio();
    final response = await dio.get("${ApiPath.getGoodsReceiptHeaderById}/$goodsReceiptHeaderId");
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(response.data as Map<String, dynamic>, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderByParamsPagedList(int pageNumber, int pageSize, GoodsReceiptHeaderDto dto) async {
    final dio = await loadDio();
    final parameters = <String, dynamic>{};
    parameters['pageNumber'] = pageNumber;
    parameters['pageSize'] = pageSize;
    for (var entry in dto.toJson().entries) {
      if (entry.value != null && entry.value.toString().isNotEmpty) {
        parameters[entry.key] = entry.value;
      }
    }
    final response = await dio.get(
      ApiPath.getGoodsReceiptHeaderByParamsPagedList,
      queryParameters: parameters,
    );
    return ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<GoodsReceiptHeaderDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => List<GoodsReceiptHeaderDto>.from(
                json.map((e) => GoodsReceiptHeaderDto.fromJson(e as Map<String, dynamic>)).toList())));
  }

  @override
  Future<ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>> getGoodsReceiptHeaderPagedList(int pageNumber, int pageSize) async {
    final dio = await loadDio();
    final parameters = <String, dynamic>{};
    parameters['pageNumber'] = pageNumber;
    parameters['pageSize'] = pageSize;
    final response = await dio.get(
      ApiPath.getGoodsReceiptHeaderPagedList,
      queryParameters: parameters,
    );
    return ApiResponseDto<PagedListDto<GoodsReceiptHeaderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<GoodsReceiptHeaderDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => List<GoodsReceiptHeaderDto>.from(
                json.map((e) => GoodsReceiptHeaderDto.fromJson(e as Map<String, dynamic>)).toList())));
  }

  @override
  Future<ApiResponseDto<GoodsReceiptHeaderDto>> updateGoodsReceiptHeader(GoodsReceiptHeaderDto goodsReceiptHeader) async {
    final dio = await loadDio();
    final response = await dio.put(ApiPath.updateGoodsReceiptHeader, data: goodsReceiptHeader);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<GoodsReceiptHeaderDto>.fromJson(responseBody, (json) => GoodsReceiptHeaderDto.fromJson(json as Map<String, dynamic>));
  }
}
