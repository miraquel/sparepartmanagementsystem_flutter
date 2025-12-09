import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationTemplateDalImplementation extends OperationTemplateDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<OperationTemplateDto>> add(OperationTemplateDto dto) async {
    final response = await _dio.post(ApiPath.addOperationTemplate, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(
      responseBody,
      (json) => OperationTemplateDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateDto>> delete(int id) async {
    final response = await _dio.delete("${ApiPath.deleteOperationTemplate}/$id");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateDto>>> getAll() async {
    final response = await _dio.get(ApiPath.getAllOperationTemplates);
    return ApiResponseDto<List<OperationTemplateDto>>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => json.map<OperationTemplateDto>((e) => OperationTemplateDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateDto>> getById(int id) async {
    final response = await _dio.get("${ApiPath.getOperationTemplateById}/$id");
    return ApiResponseDto<OperationTemplateDto>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => OperationTemplateDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationTemplateDto>>> getByParams(OperationTemplateDto dto) async {
    final response = await _dio.get(
      ApiPath.getOperationTemplateByParams,
      queryParameters: dto.toJson(),
    );
    return ApiResponseDto<List<OperationTemplateDto>>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => json.map<OperationTemplateDto>((e) => OperationTemplateDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTemplateDto>> update(OperationTemplateDto dto) async {
    final response = await _dio.put(ApiPath.updateOperationTemplate, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationTemplateDto>.fromJson(
      responseBody,
      (json) => OperationTemplateDto.fromJson(json as Map<String, dynamic>),
    );
  }

}