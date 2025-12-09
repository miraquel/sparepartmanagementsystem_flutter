import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_row_dto.dart';

abstract class OperationTemplateRowDal {
  Future<ApiResponseDto<OperationTemplateRowDto>> add(OperationTemplateRowDto dto);
  Future<ApiResponseDto<OperationTemplateRowDto>> update(OperationTemplateRowDto dto);
  Future<ApiResponseDto<OperationTemplateRowDto>> delete(int operationTemplateRowId);
  Future<ApiResponseDto<OperationTemplateRowDto>> getById(int operationTemplateRowId);
  Future<ApiResponseDto<List<OperationTemplateRowDto>>> getAll(int operationTemplateId);
  Future<ApiResponseDto<List<OperationTemplateRowDto>>> getByParams(int operationTemplateId, OperationTemplateRowDto parameters);
}