import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_entry_line_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationEntryLineDalImplementation extends OperationEntryLineDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<OperationEntryLineDto>> add(OperationEntryLineDto dto) async {
    final response = await _dio.post(ApiPath.addOperationEntryLine, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationEntryLineDto>.fromJson(
      responseBody,
      (json) => OperationEntryLineDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<OperationEntryLineDto>> delete(int operationEntryLineId) async {
    final response = await _dio.delete("${ApiPath.deleteOperationEntryLine}/$operationEntryLineId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationEntryLineDto>.fromJson(
      responseBody,
      (json) => OperationEntryLineDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationEntryLineDto>>> getAll(int operationEntryHeaderId) async {
    final response = await _dio.get("${ApiPath.getAllOperationEntryLines}/$operationEntryHeaderId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationEntryLineDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationEntryLineDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationEntryLineDto>> getById(int operationEntryLineId) async {
    final response = await _dio.get("${ApiPath.getOperationEntryLineById}/$operationEntryLineId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationEntryLineDto>.fromJson(
      responseBody,
      (json) => OperationEntryLineDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationEntryLineDto>>> getByParams(Map<String, String> parameters) async {
    final response = await _dio.get(ApiPath.getOperationEntryLineByParams, queryParameters: parameters);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationEntryLineDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationEntryLineDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationEntryLineDto>>> update(List<OperationEntryLineDto> dto) async {
    final response = await _dio.put(ApiPath.updateOperationEntryLine, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationEntryLineDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationEntryLineDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

}