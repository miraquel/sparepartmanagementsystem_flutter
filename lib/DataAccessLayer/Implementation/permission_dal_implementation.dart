import 'package:dio/dio.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/permission_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/permission_dal.dart';
import '../api_path.dart';

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
  Future<ApiResponseDto<List<PermissionDto>>> fetchAllModule() async {
    final response = await _dio.get(ApiPath.fetchAllModule);
    return ApiResponseDto<List<PermissionDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> fetchAllPermissionType() async {
    final response = await _dio.get(ApiPath.fetchAllPermissionType);
    return ApiResponseDto<List<PermissionDto>>.fromJson(response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> fetchPermission() async {
    final response = await _dio.get(ApiPath.fetchPermission);
    return ApiResponseDto<List<PermissionDto>>.fromJson(response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> fetchPermissionByRoleId(int roleId) async {
    final response = await _dio.get('${ApiPath.fetchPermissionByRoleId}/$roleId');
    return ApiResponseDto<List<PermissionDto>>.fromJson(response.data as Map<String, dynamic>, (json) => json.map<PermissionDto>((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList());
  }
}
