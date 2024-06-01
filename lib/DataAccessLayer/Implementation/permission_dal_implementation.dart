import 'package:dio/dio.dart';

import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/permission_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/permission_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';

class PermissionDALImplementation implements PermissionDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addPermission(PermissionDto permission) async {
    final response = await _dio.post(ApiPath.addPermission, data: permission);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deletePermission(int permissionId) async {
    final response = await _dio.delete("${ApiPath.deletePermission}/$permissionId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> getAllModules() async {
    final response = await _dio.get(ApiPath.getAllModules);
    return ApiResponseDto<List<PermissionDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> getAllPermissionType() async {
    final response = await _dio.get(ApiPath.getAllPermissionType);
    return ApiResponseDto<List<PermissionDto>>.fromJson(response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> getAllPermission() async {
    final response = await _dio.get(ApiPath.getAllPermission);
    return ApiResponseDto<List<PermissionDto>>.fromJson(response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> getPermissionByRoleId(int roleId) async {
    final response = await _dio.get('${ApiPath.getPermissionByRoleId}/$roleId');
    return ApiResponseDto<List<PermissionDto>>.fromJson(response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }
}
