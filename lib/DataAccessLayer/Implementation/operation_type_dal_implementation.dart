import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_type_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class OperationTypeDalImplementation extends OperationTypeDal {
  final Dio _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<OperationTypeDto>> add(OperationTypeDto dto) async {
    final response = await _dio.post(ApiPath.addOperationType, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<OperationTypeDto>.fromJson(
      responseBody,
      (json) => OperationTypeDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto> delete(int id) async {
    final response = await _dio.delete("${ApiPath.deleteOperationType}/$id");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> update(OperationTypeDto dto) async {
    final response = await _dio.put(ApiPath.updateOperationType, data: dto);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<OperationTypeDto>>> getAll() async {
    final response = await _dio.get(ApiPath.getAllOperationType);
    return ApiResponseDto<List<OperationTypeDto>>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => json.map<OperationTypeDto>((e) => OperationTypeDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<OperationTypeDto>> getById(int id) async {
    final response = await _dio.get("${ApiPath.getOperationTypeById}/$id");
    return ApiResponseDto<OperationTypeDto>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => OperationTypeDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<List<OperationTypeDto>>> getByParams(OperationTypeDto dto) async {
    final response = await _dio.get(
        ApiPath.getOperationTypeByParams,
        queryParameters: dto.toJson()
    );
    return ApiResponseDto<List<OperationTypeDto>>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => json.map<OperationTypeDto>((e) => OperationTypeDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }



}