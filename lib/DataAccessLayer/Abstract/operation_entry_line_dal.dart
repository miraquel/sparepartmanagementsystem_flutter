import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_line_dto.dart';

abstract class OperationEntryLineDal {
  Future<ApiResponseDto<OperationEntryLineDto>> add(OperationEntryLineDto dto);
  Future<ApiResponseDto<OperationEntryLineDto>> delete(int operationEntryLineId);
  Future<ApiResponseDto<List<OperationEntryLineDto>>> update(List<OperationEntryLineDto> dto);
  Future<ApiResponseDto<List<OperationEntryLineDto>>> getAll(int operationEntryHeaderId);
  Future<ApiResponseDto<OperationEntryLineDto>> getById(int operationEntryLineId);
  Future<ApiResponseDto<List<OperationEntryLineDto>>> getByParams(Map<String, String> parameters);
}