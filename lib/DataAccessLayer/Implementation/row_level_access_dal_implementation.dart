import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/row_level_access_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/row_level_access_dto.dart';

import '../../service_locator_setup.dart';

class RowLevelAccessDALImplementation implements RowLevelAccessDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addRowLevelAccess(RowLevelAccessDto rowLevelAccess) async {
    final response = await _dio.post(
      ApiPath.addRowLevelAccess,
      data: rowLevelAccess,
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deleteRowLevelAccess(int rowLevelAccessId) async {
    final response = await _dio.delete("${ApiPath.deleteRowLevelAccess}/$rowLevelAccessId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<RowLevelAccessDto>> getRowLevelAccessById(int rowLevelAccessId) async {
    final response = await _dio.get('${ApiPath.getRowLevelAccessById}/$rowLevelAccessId');
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<RowLevelAccessDto>.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<RowLevelAccessDto>>> getRowLevelAccess() async {
    final response = await _dio.get(ApiPath.getRowLevelAccess);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<RowLevelAccessDto>>.fromJson(responseBody, (json) => json.map<RowLevelAccessDto>((e) => RowLevelAccessDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<List<RowLevelAccessDto>>> getRowLevelAccessByParams(RowLevelAccessDto dto) async {
    final response = await _dio.get(ApiPath.getRowLevelAccessByParams, queryParameters: dto.toJson());
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<RowLevelAccessDto>>.fromJson(responseBody, (json) => json.map<RowLevelAccessDto>((e) => RowLevelAccessDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto> updateRowLevelAccess(RowLevelAccessDto rowLevelAccess) async {
    final response = await _dio.put(
      ApiPath.updateRowLevelAccess,
      data: rowLevelAccess,
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<RowLevelAccessDto>>> getRowLevelAccessByUserId(int userId) async {
    final response = await _dio.get('${ApiPath.getRowLevelAccessByUserId}/$userId');
    return ApiResponseDto<List<RowLevelAccessDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => json.map<RowLevelAccessDto>((e) => RowLevelAccessDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto> bulkDeleteRowLevelAccess(List<int> rowLevelAccessIds) async {
    final response = await _dio.post(ApiPath.bulkDeleteRowLevelAccess, data: rowLevelAccessIds);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

}