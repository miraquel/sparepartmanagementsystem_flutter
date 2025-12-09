import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';

abstract class OperationTypeDal {
  Future<ApiResponseDto<OperationTypeDto>> add(OperationTypeDto dto);
  Future<ApiResponseDto> delete(int id);
  Future<ApiResponseDto> update(OperationTypeDto dto);
  Future<ApiResponseDto<List<OperationTypeDto>>> getAll();
  Future<ApiResponseDto<OperationTypeDto>> getById(int id);
  Future<ApiResponseDto<List<OperationTypeDto>>> getByParams(OperationTypeDto dto);
}