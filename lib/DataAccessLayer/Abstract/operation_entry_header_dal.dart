import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_header_dto.dart';

abstract class OperationEntryHeaderDal {
  Future<ApiResponseDto<OperationEntryHeaderDto>> add(OperationEntryHeaderDto dto);
  Future<ApiResponseDto<OperationEntryHeaderDto>> delete(int operationEntryHeaderId);
  Future<ApiResponseDto<OperationEntryHeaderDto>> update(OperationEntryHeaderDto dto);
  Future<ApiResponseDto<List<OperationEntryHeaderDto>>> getAll();
  Future<ApiResponseDto<OperationEntryHeaderDto>> getById(int operationEntryHeaderId);
  Future<ApiResponseDto<List<OperationEntryHeaderDto>>> getByParams(Map<String, dynamic> params);
}