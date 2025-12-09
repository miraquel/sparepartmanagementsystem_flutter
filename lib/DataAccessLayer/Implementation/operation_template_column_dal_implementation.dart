import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_column_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_column_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationTemplateColumnDalImplementation extends OperationTemplateColumnDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<OperationTemplateColumnDto>> add(OperationTemplateColumnDto dto) async {
    final response = await _dio.post(ApiPath.addOperationTemplateColumn, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(
      responseBody,
      (json) => OperationTemplateColumnDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateColumnDto>> delete(int operationTemplateColumnId) async {
    final response = await _dio.delete("${ApiPath.deleteOperationTemplateColumn}/$operationTemplateColumnId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateColumnDto>>> getAll(int operationTemplateId) async {
    final response = await _dio.get("${ApiPath.getAllOperationTemplateColumns}/$operationTemplateId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationTemplateColumnDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationTemplateColumnDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateColumnDto>>> getByParams(int operationTemplateId, OperationTemplateColumnDto parameters) async {
    final response = await _dio.get("${ApiPath.getOperationTemplateColumnByParams}/$operationTemplateId", queryParameters: parameters.toJson());
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationTemplateColumnDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationTemplateColumnDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateColumnDto>> getById(int operationTemplateColumnId) async {
    final response = await _dio.get("${ApiPath.getOperationTemplateColumnById}/$operationTemplateColumnId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationTemplateColumnDto>.fromJson(
      responseBody,
      (json) => OperationTemplateColumnDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateColumnDto>> update(OperationTemplateColumnDto dto) async {
    final response = await _dio.put(ApiPath.updateOperationTemplateColumn, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(
      responseBody,
      (json) => OperationTemplateColumnDto.fromJson(json as Map<String, dynamic>),
    );
  }
}