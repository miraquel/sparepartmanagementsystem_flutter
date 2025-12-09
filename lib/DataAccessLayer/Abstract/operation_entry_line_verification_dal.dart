import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_verification_dto.dart';

abstract class OperationEntryVerificationDal {
  Future<ApiResponseDto> add(OperationEntryVerificationDto dto);
  Future<ApiResponseDto> delete(int id);
  Future<ApiResponseDto> update(OperationEntryVerificationDto dto);
  Future<ApiResponseDto<List<OperationEntryVerificationDto>>> getAll();
  Future<ApiResponseDto<OperationEntryVerificationDto>> getById(int id);
  Future<ApiResponseDto<List<OperationEntryVerificationDto>>> getByParams(Map<String, String> parameters);
}