import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_row_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_row_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationTemplateRowDalImplementation extends OperationTemplateRowDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<OperationTemplateRowDto>> add(OperationTemplateRowDto dto) async {
    final response = await _dio.post(ApiPath.addOperationTemplateRow, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(
      responseBody,
      (json) => OperationTemplateRowDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateRowDto>> delete(int operationTemplateRowId) async {
    final response = await _dio.delete("${ApiPath.deleteOperationTemplateRow}/$operationTemplateRowId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateRowDto>>> getAll(int operationTemplateId) async {
    final response = await _dio.get("${ApiPath.getAllOperationTemplateRows}/$operationTemplateId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationTemplateRowDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationTemplateRowDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateRowDto>> getById(int operationTemplateRowId) async {
    final response = await _dio.get("${ApiPath.getOperationTemplateRowById}/$operationTemplateRowId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationTemplateRowDto>.fromJson(
      responseBody,
      (json) => OperationTemplateRowDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateRowDto>>> getByParams(int operationTemplateId, OperationTemplateRowDto dto) async {
    final response = await _dio.get("${ApiPath.getOperationTemplateRowByParams}/$operationTemplateId", queryParameters: dto.toJson());
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationTemplateRowDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationTemplateRowDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateRowDto>> update(OperationTemplateRowDto dto) async {
    final response = await _dio.put(ApiPath.updateOperationTemplateRow, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationTemplateRowDto>.fromJson(
      responseBody,
      (json) => OperationTemplateRowDto.fromJson(json as Map<String, dynamic>),
    );
  }

}