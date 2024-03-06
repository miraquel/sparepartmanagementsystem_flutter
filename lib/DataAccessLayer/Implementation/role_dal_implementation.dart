import 'package:dio/dio.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/role_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/role_dal.dart';
import '../api_path.dart';

class RoleDALImplementation implements RoleDAL {
  Future<Dio> loadDio() async => await locator.getAsync<Dio>();

  @override
  Future<ApiResponseDto<RoleDto>> addRole(RoleDto role) async {
    final dio = await loadDio();
    final response = await dio.post(
      ApiPath.addRole,
      data: role,
    );

    return ApiResponseDto<RoleDto>.fromJson(response.data as Map<String, dynamic>, (json) => RoleDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<RoleDto>> addUserToRole(int roleId, int userId) async {
    final dio = await loadDio();
    final response = await dio.post(
      ApiPath.addUserToRole,
      data: {'roleId': roleId, 'userId': userId},
    );
    return ApiResponseDto<RoleDto>.fromJson(response.data as Map<String, dynamic>, (json) => RoleDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<RoleDto>>> deleteRole(int roleId) async {
    final dio = await loadDio();
    const path = ApiPath.deleteRole;
    final response = await dio.delete("$path/$roleId");

    return ApiResponseDto<List<RoleDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<RoleDto>.from(json.map((e) => RoleDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<RoleDto>> deleteUserFromRole(int roleId, int userId) async {
    final dio = await loadDio();
    final response = await dio.delete(
      ApiPath.deleteUserFromRole,
      queryParameters: {'roleId': roleId, 'userId': userId},
    );

    return ApiResponseDto<RoleDto>.fromJson(response.data as Map<String, dynamic>, (json) => RoleDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<RoleDto>> fetchByIdWithUsers(int roleId) async {
    final dio = await loadDio();
    var path = ApiPath.fetchByIdWithUsers;
    final response = await dio.get('$path/$roleId');

    return ApiResponseDto<RoleDto>.fromJson(response.data as Map<String, dynamic>, (json) => RoleDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<RoleDto>>> fetchRole() async {
    final dio = await loadDio();
    final response = await dio.get(
      ApiPath.fetchRole,
    );

    return ApiResponseDto<List<RoleDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<RoleDto>.from(json.map((e) => RoleDto.fromJson(e as Map<String, dynamic>)).toList()));
  }
}
