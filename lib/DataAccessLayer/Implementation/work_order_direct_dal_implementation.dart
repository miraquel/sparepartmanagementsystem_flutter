import 'package:dio/dio.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_order_direct_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkOrderDirectDALImplementation implements WorkOrderDirectDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addItemRequisition(InventReqDto dto) {
    final response = _dio.post(ApiPath.addItemRequisitionDirect, data: dto);
    return response.then((value) => ApiResponseDto.fromJson(value.data));
  }

  @override
  Future<ApiResponseDto> addWorkOrderLine(WorkOrderLineDto dto) {
    final response = _dio.post(ApiPath.addWorkOrderLineDirect, data: dto);
    return response.then((value) => ApiResponseDto.fromJson(value.data));
  }

  @override
  Future<ApiResponseDto> deleteItemRequisition(InventReqDto dto) {
    final response = _dio.delete(ApiPath.deleteItemRequisitionDirect, queryParameters: dto.toJson());
    return response.then((value) => ApiResponseDto.fromJson(value.data));
  }

  @override
  Future<ApiResponseDto<InventReqDto>> getItemRequisition(InventReqDto dto) {
    final response = _dio.post(ApiPath.getItemRequisitionDirect, queryParameters: dto.toJson());
    return response.then((value) => ApiResponseDto<InventReqDto>.fromJson(value.data, (json) => InventReqDto.fromJson(json)));
  }

  @override
  Future<ApiResponseDto<List<InventReqDto>>> getItemRequisitionList(int agsWORecId) async {
    final response = await _dio.get(ApiPath.getItemRequisitionListDirect, queryParameters: {'agsWORecId': agsWORecId});
    return ApiResponseDto<List<InventReqDto>>.fromJson(response.data, (json) => json.map<InventReqDto>((e) => InventReqDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto<WorkOrderHeaderDto>> getWorkOrderHeader(String agsEamWoId) {
    final response = _dio.get(ApiPath.getWorkOrderHeaderDirect, queryParameters: {'agsEamWoId': agsEamWoId});
    return response.then((value) => ApiResponseDto<WorkOrderHeaderDto>.fromJson(value.data, (json) => WorkOrderHeaderDto.fromJson(json)));
  }

  @override
  Future<ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>> getWorkOrderHeaderPagedList(int pageNumber, int pageSize, WorkOrderHeaderSearchDto dto) {
    final response = _dio.get(ApiPath.getWorkOrderHeaderPagedListDirect, queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize, ...dto.toJson()});
    return response.then((value) => ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>.fromJson(value.data, (json) => PagedListDto<WorkOrderHeaderDto>.fromJson(json as Map<String, dynamic>, (json) => json.map<WorkOrderHeaderDto>((e) => WorkOrderHeaderDto.fromJson(e)).toList())));
  }

  @override
  Future<ApiResponseDto<WorkOrderLineDto>> getWorkOrderLine(String agsEamWoId, int line) {
    final response = _dio.get(ApiPath.getWorkOrderLineDirect, queryParameters: {'agsEamWoId': agsEamWoId, 'line': line});
    return response.then((value) => ApiResponseDto<WorkOrderLineDto>.fromJson(value.data, (json) => WorkOrderLineDto.fromJson(json)));
  }

  @override
  Future<ApiResponseDto<List<WorkOrderLineDto>>> getWorkOrderLineList(String agsEamWoId) {
    final response = _dio.get(ApiPath.getWorkOrderLineListDirect, queryParameters: {'agsEamWoId': agsEamWoId});
    return response.then((value) => ApiResponseDto<List<WorkOrderLineDto>>.fromJson(value.data, (json) => json.map<WorkOrderLineDto>((e) => WorkOrderLineDto.fromJson(e)).toList()));
  }

  @override
  Future<ApiResponseDto> updateItemRequisition(InventReqDto dto) {
    final response = _dio.put(ApiPath.updateItemRequisitionDirect, data: dto);
    return response.then((value) => ApiResponseDto.fromJson(value.data));
  }

  @override
  Future<ApiResponseDto> updateWorkOrderLine(WorkOrderLineDto dto) {
    final response = _dio.put(ApiPath.updateWorkOrderLineDirect, data: dto);
    return response.then((value) => ApiResponseDto.fromJson(value.data));
  }

  @override
  Future<ApiResponseDto> createInventJournalTable(WorkOrderLineDto dto) async {
    final response = await _dio.post(ApiPath.createInventJournalTable, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> deleteItemRequisitionWithListOfRecId(List<int> recIds) async {
    final response = await _dio.delete(ApiPath.deleteItemRequisitionDirectWithListOfRecId, queryParameters: {'recIds': recIds});
    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> closeWorkOrderLineAndPostInventJournal(WorkOrderLineDto dto) async {
    final response = await _dio.post(ApiPath.closeWorkOrderLineAndPostInventJournalDirect, data: dto);
    return ApiResponseDto.fromJson(response.data);
  }

}