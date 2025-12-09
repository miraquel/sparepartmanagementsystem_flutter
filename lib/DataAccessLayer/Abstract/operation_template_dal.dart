import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';

abstract class OperationTemplateDal {
  Future<ApiResponseDto<OperationTemplateDto>> add(OperationTemplateDto dto);
  Future<ApiResponseDto<OperationTemplateDto>> delete(int id);
  Future<ApiResponseDto<OperationTemplateDto>> update(OperationTemplateDto dto);
  Future<ApiResponseDto<OperationTemplateDto>> getById(int id);
  Future<ApiResponseDto<List<OperationTemplateDto>>> getAll();
  Future<ApiResponseDto<List<OperationTemplateDto>>> getByParams(OperationTemplateDto dto);
}