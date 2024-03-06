import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_search_dto.dart';

import '../../Model/paged_list_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/gmk_sms_service_group_dal.dart';

class GMKSMSServiceGroupDALImplementation implements GMKSMSServiceGroupDAL {
  Future<Dio> loadDio() async => await locator.getAsync<Dio>();

  @override
  Future<ApiResponseDto<PagedListDto<InventTableDto>>> getInventTablePagedList(int pageNumber, int pageSize, InventTableSearchDto dto) async {
    final dio = await loadDio();
    var parameters = <String, dynamic>{};
    for (var entry in dto.toJson().entries) {
      if (entry.value != null && entry.value.toString().isNotEmpty) {
        parameters[entry.key] = entry.value;
      }
    }
    final response = await dio.get(
        ApiPath.getInventTablePagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...parameters}
    );
    return ApiResponseDto<PagedListDto<InventTableDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<InventTableDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => List<InventTableDto>.from(
                json.map((e) => InventTableDto.fromJson(e as Map<String, dynamic>)).toList())));
  }

  @override
  Future<String> getImageFromNetworkUri(String networkUri) async {
    final dio = await loadDio();
    final response = await dio.get(
        ApiPath.getImageFromNetworkUri,
        queryParameters: {'networkUri': networkUri},
        options: Options(responseType: ResponseType.bytes));
    return response.data.toString();
  }

  @override
  Future<String> getImageWithResolutionFromNetworkUri(String networkUri, int maxLength) async {
    final dio = await loadDio();
    final response = await dio.get(
        ApiPath.getImageWithResolutionFromNetworkUri,
        queryParameters: {'networkUri': networkUri, 'maxLength': maxLength},
        options: Options(responseType: ResponseType.bytes));
    return response.data.toString();
  }

  @override
  Future<ApiResponseDto<PagedListDto<PurchTableDto>>> getPurchTablePagedList(int pageNumber, int pageSize, PurchTableSearchDto dto) async {
    final dio = await loadDio();
    var parameters = <String, dynamic>{};
    for (var entry in dto.toJson().entries) {
      if (entry.value != null && entry.value.toString().isNotEmpty) {
        parameters[entry.key] = entry.value;
      }
    }
    final response = await dio.get(
        ApiPath.getPurchTablePagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...parameters}
    );

    return ApiResponseDto<PagedListDto<PurchTableDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<PurchTableDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => List<PurchTableDto>.from(
                json.map((e) => PurchTableDto.fromJson(e as Map<String, dynamic>)).toList())));
  }
}