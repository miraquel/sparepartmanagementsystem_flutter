import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/dimension_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_ax_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_ax_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_ax_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class GMKSMSServiceGroupDALImplementation implements GMKSMSServiceGroupDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<PagedListDto<InventTableDto>>> getInventTablePagedList(int pageNumber, int pageSize, InventTableSearchDto dto) async {
    var queryParameters = {'pageNumber': pageNumber, 'pageSize': pageSize, ...dto.toJson()};
    final response = await _dio.get(
        ApiPath.getInventTablePagedList,
        queryParameters: queryParameters
    );
    return ApiResponseDto<PagedListDto<InventTableDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<InventTableDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => json.map<InventTableDto>((e) => InventTableDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<PagedListDto<InventTableDto>>> getRawInventTablePagedList(int pageNumber, int pageSize, InventTableSearchDto dto) async {
    var queryParameters = {'pageNumber': pageNumber, 'pageSize': pageSize, ...dto.toJson()};
    final response = await _dio.get(
        ApiPath.getRawInventTablePagedList,
        queryParameters: queryParameters
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
    final response = await _dio.get(
        ApiPath.getPurchTablePagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...dto.toJson()}
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
    final response = await _dio.get(
        ApiPath.getWMSLocationPagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...dto.toJson()}
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
        response.data,
        (json) => PurchTableDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<InventSumDto>>> getInventSumList(InventSumSearchDto dto) async {
    final response = await _dio.get(ApiPath.getInventSumList, queryParameters: dto.toJson());
    return ApiResponseDto<List<InventSumDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json.map<InventSumDto>((e) => InventSumDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto<PagedListDto<WorkOrderAxDto>>> getWorkOrderPagedList(int pageNumber, int pageSize, WorkOrderSearchDto dto) async {
    final response = await _dio.get(
        ApiPath.getWorkOrderPagedList,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...dto.toJson()}
    );
    return ApiResponseDto<PagedListDto<WorkOrderAxDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedListDto<WorkOrderAxDto>.fromJson(
            json as Map<String, dynamic>,
            (json) => json.map<WorkOrderAxDto>((e) => WorkOrderAxDto.fromJson(e)).toList()));
  }

  @override
  Future<ApiResponseDto<List<WorkOrderLineAxDto>>> getWorkOrderLineList(String workOrderHeaderId) async {
    final response = await _dio.get(ApiPath.getWorkOrderLineList, queryParameters: {'workOrderHeaderId': workOrderHeaderId});
    return ApiResponseDto<List<WorkOrderLineAxDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json.map<WorkOrderLineAxDto>((e) => WorkOrderLineAxDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto<List<InventLocationDto>>> getInventLocationList(InventLocationDto dto) async {
    final response = await _dio.get(ApiPath.getInventLocationList);
    return ApiResponseDto<List<InventLocationDto>>.fromJson(
        response.data,
        (json) => json.map<InventLocationDto>((e) => InventLocationDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto<WMSLocationDto>> getWMSLocation(WMSLocationDto dto) async {
    final response = await _dio.get(ApiPath.getWMSLocation, queryParameters: dto.toJson());
    return ApiResponseDto<WMSLocationDto>.fromJson(response.data, (json) => WMSLocationDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<InventTableDto>> getInventTable(String itemId) async {
    final response = await _dio.get("${ApiPath.getInventTable}/$itemId");
    return ApiResponseDto<InventTableDto>.fromJson(response.data, (json) => InventTableDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<DimensionDto>>> getDimensionList(String dimensionName) async {
    final response = await _dio.get(ApiPath.getDimensionList, queryParameters: {'dimensionName': dimensionName});
    return ApiResponseDto<List<DimensionDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json.map<DimensionDto>((e) => DimensionDto.fromJson(e)).toList());
  }
}