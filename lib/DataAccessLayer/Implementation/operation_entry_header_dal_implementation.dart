import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_entry_header_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationEntryHeaderDalImplementation extends OperationEntryHeaderDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<OperationEntryHeaderDto>> add(OperationEntryHeaderDto dto) async {
    final response = await _dio.post(ApiPath.addOperationEntryHeader, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<OperationEntryHeaderDto>> delete(int operationEntryHeaderId) async {
    final response = await _dio.delete("${ApiPath.deleteOperationEntryHeader}/$operationEntryHeaderId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<OperationEntryHeaderDto>>> getAll() async {
    final response = await _dio.get(ApiPath.getAllOperationEntryHeaders);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationEntryHeaderDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationEntryHeaderDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationEntryHeaderDto>> getById(int operationEntryHeaderId) async {
    final response = await _dio.get("${ApiPath.getOperationEntryHeaderById}/$operationEntryHeaderId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationEntryHeaderDto>.fromJson(
      responseBody,
      (json) => OperationEntryHeaderDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationEntryHeaderDto>>> getByParams(Map<String, dynamic> parameters) async {
    final response = await _dio.get(ApiPath.getOperationEntryHeaderByParams, queryParameters: parameters);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationEntryHeaderDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationEntryHeaderDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationEntryHeaderDto>> update(OperationEntryHeaderDto dto) async {
    final response = await _dio.put(ApiPath.updateOperationEntryHeader, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationEntryHeaderDto>.fromJson(
      responseBody,
      (json) => OperationEntryHeaderDto.fromJson(json as Map<String, dynamic>),
    );
  }

}