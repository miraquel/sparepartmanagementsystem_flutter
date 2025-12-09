import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_column_dto.dart';

abstract class OperationTemplateColumnDal {
  Future<ApiResponseDto<OperationTemplateColumnDto>> add(OperationTemplateColumnDto dto);
  Future<ApiResponseDto<OperationTemplateColumnDto>> delete(int operationTemplateColumnId);
  Future<ApiResponseDto<OperationTemplateColumnDto>> update(OperationTemplateColumnDto dto);
  Future<ApiResponseDto<List<OperationTemplateColumnDto>>> getAll(int operationTemplateId);
  Future<ApiResponseDto<OperationTemplateColumnDto>> getById(int operationTemplateColumnId);
  Future<ApiResponseDto<List<OperationTemplateColumnDto>>> getByParams(int operationTemplateId, OperationTemplateColumnDto parameters);
}