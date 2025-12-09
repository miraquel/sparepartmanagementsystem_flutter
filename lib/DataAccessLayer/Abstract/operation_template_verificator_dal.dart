import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_verificator_dto.dart';

abstract class OperationTemplateVerificatorDal {
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> add(OperationTemplateVerificatorDto dto);
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> update(OperationTemplateVerificatorDto dto);
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> delete(int operationTemplateVerificatorId);
  Future<ApiResponseDto<OperationTemplateVerificatorDto>> getById(int operationTemplateVerificatorId);
  Future<ApiResponseDto<List<OperationTemplateVerificatorDto>>> getAll(int operationTemplateId);
  Future<ApiResponseDto<List<OperationTemplateVerificatorDto>>> getByParams(int operationTemplateId, OperationTemplateVerificatorDto parameters);
}