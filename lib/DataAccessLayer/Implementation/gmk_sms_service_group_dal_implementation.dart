import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_search_dto.dart';

import '../../Model/paged_list_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/gmk_sms_service_group_dal.dart';

class GMKSMSServiceGroupDALImplementation implements GMKSMSServiceGroupDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<PagedListDto<InventTableDto>>> getInventTablePagedList(int pageNumber, int pageSize, InventTableSearchDto dto) async {
    var parameters = <String, dynamic>{};
    for (var entry in dto.toJson().entries) {
      if (entry.value != null && entry.value.toString().isNotEmpty) {
        parameters[entry.key] = entry.value;
      }
    }
    final response = await _dio.get(
        ApiPath.getInventTablePagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...parameters}
    );
    return ApiResponseDto<PagedListDto<InventTableDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<InventTableDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => json.map<InventTableDto>((e) => InventTableDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<String> getImageFromNetworkUri(String networkUri) async {
    final response = await _dio.get(
        ApiPath.getImageFromNetworkUri,
        queryParameters: {'networkUri': networkUri},
        options: Options(responseType: ResponseType.bytes));
    return response.data.toString();
  }

  @override
  Future<String> getImageWithResolutionFromNetworkUri(String networkUri, int maxLength) async {
    final response = await _dio.get(
        ApiPath.getImageWithResolutionFromNetworkUri,
        queryParameters: {'networkUri': networkUri, 'maxLength': maxLength},
        options: Options(responseType: ResponseType.bytes));
    return response.data.toString();
  }

  @override
  Future<ApiResponseDto<PagedListDto<PurchTableDto>>> getPurchTablePagedList(int pageNumber, int pageSize, PurchTableSearchDto dto) async {
    var parameters = <String, dynamic>{};
    for (var entry in dto.toJson().entries) {
      if (entry.value != null && entry.value.toString().isNotEmpty) {
        parameters[entry.key] = entry.value;
      }
    }
    final response = await _dio.get(
        ApiPath.getPurchTablePagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...parameters}
    );

    return ApiResponseDto<PagedListDto<PurchTableDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<PurchTableDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => json.map<PurchTableDto>((e) => PurchTableDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<List<PurchLineDto>>> getPurchLineList(String purchId) async {
    final response = await _dio.get(ApiPath.getPurchLineList, queryParameters: {'purchId': purchId});
    return ApiResponseDto<List<PurchLineDto>>.fromJson(
        response.data as Map<String, dynamic>,
            (json) => json.map<PurchLineDto>((e) => PurchLineDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<PagedListDto<WMSLocationDto>>> getWMSLocationPagedList(int pageNumber, int pageSize, WMSLocationSearchDto dto) async {
    var parameters = <String, dynamic>{};
    for (var entry in dto.toJson().entries) {
      if (entry.value != null && entry.value.toString().isNotEmpty) {
        parameters[entry.key] = entry.value;
      }
    }
    final response = await _dio.get(
        ApiPath.getWMSLocationPagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...parameters}
    );
    return ApiResponseDto<PagedListDto<WMSLocationDto>>.fromJson(
        response.data as Map<String, dynamic>,
            (json) => PagedListDto<WMSLocationDto>.fromJson(
            json as Map<String, dynamic>,
                (json) => json.map<WMSLocationDto>((e) => WMSLocationDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<PurchTableDto>> getPurchTable(String purchId) async {
    final response = await _dio.get("${ApiPath.getPurchTable}/$purchId");
    return ApiResponseDto<PurchTableDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PurchTableDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<List<InventSumDto>>> getInventSumList(InventSumSearchDto dto) async {
    final response = await _dio.get(ApiPath.getInventSumList, queryParameters: dto.toJson());
    return ApiResponseDto<List<InventSumDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json.map<InventSumDto>((e) => InventSumDto.fromJson(e as Map<String, dynamic>)).toList());
  }
}