import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_verificator_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_verificator_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationTemplateVerificatorDalImplementation implements OperationTemplateVerificatorDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> add(OperationTemplateVerificatorDto dto) async {
    final response = await _dio.post(ApiPath.addOperationTemplateVerificator, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(
      responseBody,
      (json) => OperationTemplateVerificatorDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> delete(int operationTemplateVerificatorId) async {
    final response = await _dio.delete("${ApiPath.deleteOperationTemplateVerificator}/$operationTemplateVerificatorId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateVerificatorDto>>> getAll(int operationTemplateId) async {
    final response = await _dio.get("${ApiPath.getAllOperationTemplateVerificators}/$operationTemplateId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationTemplateVerificatorDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationTemplateVerificatorDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> getById(int operationTemplateVerificatorId) async {
    final response = await _dio.get("${ApiPath.getOperationTemplateVerificatorById}/$operationTemplateVerificatorId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationTemplateVerificatorDto>.fromJson(
      responseBody,
      (json) => OperationTemplateVerificatorDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateVerificatorDto>>> getByParams(int operationTemplateId, OperationTemplateVerificatorDto parameters) async {
    final response = await _dio.get("${ApiPath.getOperationTemplateVerificatorByParams}/$operationTemplateId", queryParameters: parameters.toJson());
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationTemplateVerificatorDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationTemplateVerificatorDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> update(OperationTemplateVerificatorDto dto) async {
    final response = await _dio.put(ApiPath.updateOperationTemplateVerificator, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationTemplateVerificatorDto>.fromJson(
      responseBody,
      (json) => OperationTemplateVerificatorDto.fromJson(json as Map<String, dynamic>),
    );
  }
}