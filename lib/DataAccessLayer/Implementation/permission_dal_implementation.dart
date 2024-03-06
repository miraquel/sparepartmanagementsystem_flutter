import 'package:dio/dio.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/permission_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/permission_dal.dart';
import '../api_path.dart';

class PermissionDALImplementation implements PermissionDAL {
  Future<Dio> loadDio() async => await locator.getAsync<Dio>();

  @override
  Future<ApiResponseDto<PermissionDto>> addPermission(PermissionDto permission) async {
    final dio = await loadDio();
    final response = await dio.post(ApiPath.addPermission, data: permission);
    return ApiResponseDto<PermissionDto>.fromJson(response.data as Map<String, dynamic>, (json) => PermissionDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<PermissionDto>> deletePermission(int permissionId) async {
    final dio = await loadDio();
    const path = ApiPath.deletePermission;
    final response = await dio.delete("$path/$permissionId");

    return ApiResponseDto<PermissionDto>.fromJson(response.data as Map<String, dynamic>, (json) => PermissionDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> fetchAllModule() async {
    final dio = await loadDio();
    final response = await dio.get(
      ApiPath.fetchAllModule,
    );

    return ApiResponseDto<List<PermissionDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<PermissionDto>.from(json.map((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> fetchAllPermissionType() async {
    final dio = await loadDio();
    final response = await dio.get(
      ApiPath.fetchAllPermissionType,
    );

    return ApiResponseDto<List<PermissionDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<PermissionDto>.from(json.map((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> fetchPermission() async {
    final dio = await loadDio();
    final response = await dio.get(
      ApiPath.fetchPermission,
    );

    return ApiResponseDto<List<PermissionDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<PermissionDto>.from(json.map((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<List<PermissionDto>>> fetchPermissionByRoleId(int roleId) async {
    final dio = await loadDio();
    const path = ApiPath.fetchPermissionByRoleId;
    final response = await dio.get('$path/$roleId');

    return ApiResponseDto<List<PermissionDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<PermissionDto>.from(json.map((e) => PermissionDto.fromJson(e as Map<String, dynamic>)).toList()));
  }
}
