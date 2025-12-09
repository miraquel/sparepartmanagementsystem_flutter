import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_entry_line_verification_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_verification_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationEntryVerificationDalImplementation extends OperationEntryVerificationDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> add(OperationEntryVerificationDto dto) async {
    final response = await _dio.post(ApiPath.addOperationEntryVerification, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> delete(int id) async {
    final response = await _dio.delete("${ApiPath.deleteOperationEntryVerification}/$id");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<OperationEntryVerificationDto>>> getAll() async {
    final response = await _dio.get(ApiPath.getAllOperationEntryVerifications);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationEntryVerificationDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationEntryVerificationDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationEntryVerificationDto>> getById(int id) async {
    final response = await _dio.get("${ApiPath.getOperationEntryVerificationById}/$id");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationEntryVerificationDto>.fromJson(
      responseBody,
      (json) => OperationEntryVerificationDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationEntryVerificationDto>>> getByParams(Map<String, String> parameters) async {
    final response = await _dio.get(ApiPath.getOperationEntryVerificationByParams, queryParameters: parameters);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<OperationEntryVerificationDto>>.fromJson(
      responseBody,
      (json) => (json as List).map((e) => OperationEntryVerificationDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto> update(OperationEntryVerificationDto dto) async {
    final response = await _dio.put(ApiPath.updateOperationEntryVerification, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

}