import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/item_requisition_dto.dart';

import '../../Model/work_order_line_dto.dart';
import '../../service_locator_setup.dart';
import '../api_path.dart';

class WorkOrderDALImplementation implements WorkOrderDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addWorkOrderHeader(WorkOrderHeaderDto dto) async {
    final response = await _dio.post(ApiPath.addWorkOrderHeader, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> addWorkOrderLine(WorkOrderLineDto dto) async {
    final response = await _dio.post(ApiPath.addWorkOrderLine, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> deleteWorkOrderHeader(int id) async {
    final response = await _dio.delete('${ApiPath.deleteWorkOrderHeader}/$id');
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> deleteWorkOrderLine(int id) async {
    final response = await _dio.delete('${ApiPath.deleteWorkOrderLine}/$id');
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>> getAllWorkOrderHeaderPagedList(int pageNumber, int pageSize) async {
    final queryParameters = {'pageNumber': pageNumber, 'pageSize': pageSize};
    final response = await _dio.get(ApiPath.getAllWorkOrderHeaderPagedList, queryParameters: queryParameters);
    return ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>.fromJson(response.data, (json) => PagedListDto<WorkOrderHeaderDto>.fromJson(json, (json) => WorkOrderHeaderDto.fromJson(json)));
  }

  @override
  Future<ApiResponseDto<WorkOrderHeaderDto>> getWorkOrderHeaderById(int id) async {
    final response = await _dio.get('${ApiPath.getWorkOrderHeaderById}/$id');
    return ApiResponseDto<WorkOrderHeaderDto>.fromJson(response.data, (json) => WorkOrderHeaderDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>> getWorkOrderHeaderByParamsPagedList(int pageNumber, int pageSize, WorkOrderHeaderDto entity) async {
    final response = await _dio.get(ApiPath.getWorkOrderHeaderByParamsPagedList, queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...entity.toJson()});
    return ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>.fromJson(response.data, (json) => PagedListDto<WorkOrderHeaderDto>.fromJson(json as Map<String, dynamic>, (json) => json.map<WorkOrderHeaderDto>((e) => WorkOrderHeaderDto.fromJson(e)).toList()));
  }

  @override
  Future<ApiResponseDto<WorkOrderLineDto>> getWorkOrderLineById(int id) async {
    final response = await _dio.get('${ApiPath.getWorkOrderLineById}/$id');
    return ApiResponseDto<WorkOrderLineDto>.fromJson(response.data, (json) => WorkOrderLineDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<WorkOrderLineDto>>> getWorkOrderLineByWorkOrderHeaderId(int id) async {
    final response = await _dio.get('${ApiPath.getWorkOrderLineByWorkOrderHeaderId}/$id');
    return ApiResponseDto<List<WorkOrderLineDto>>.fromJson(response.data, (json) => json.map<WorkOrderLineDto>((e) => WorkOrderLineDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto> updateWorkOrderHeader(WorkOrderHeaderDto dto) async {
    final response = await _dio.put(ApiPath.updateWorkOrderHeader, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> updateWorkOrderLine(WorkOrderLineDto dto) async {
    final response = await _dio.put(ApiPath.updateWorkOrderLine, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> addItemRequisition(ItemRequisitionDto dto) async {
    final response = await _dio.post(ApiPath.addItemRequisition, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> deleteItemRequisition(int id) async {
    final response = await _dio.delete('${ApiPath.deleteItemRequisition}/$id');
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto<ItemRequisitionDto>> getItemRequisitionById(int id) async {
    final response = await _dio.get('${ApiPath.getItemRequisitionById}/$id');
    return ApiResponseDto<ItemRequisitionDto>.fromJson(response.data, (json) => ItemRequisitionDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<ItemRequisitionDto>>> getItemRequisitionByParams(ItemRequisitionDto entity) async {
    final response = await _dio.get(ApiPath.getItemRequisitionByParams, queryParameters: entity.toJson());
    return ApiResponseDto<List<ItemRequisitionDto>>.fromJson(response.data, (json) => json.map<ItemRequisitionDto>((e) => ItemRequisitionDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto> updateItemRequisition(ItemRequisitionDto dto) async {
    final response = await _dio.put(ApiPath.updateItemRequisition, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto<List<ItemRequisitionDto>>> getItemRequisitionByWorkOrderLineId(int id) async {
    final response = await _dio.get('${ApiPath.getItemRequisitionByWorkOrderLineId}/$id');
    return ApiResponseDto<List<ItemRequisitionDto>>.fromJson(response.data, (json) => json.map<ItemRequisitionDto>((e) => ItemRequisitionDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto> addWorkOrderHeaderWithLines(WorkOrderHeaderDto dto) async {
    final response = await _dio.post(ApiPath.addWorkOrderHeaderWithLines, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }
}