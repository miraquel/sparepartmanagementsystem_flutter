import 'package:dio/dio.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/role_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/role_dal.dart';
import '../api_path.dart';

class RoleDALImplementation implements RoleDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addRole(RoleDto role) async {
    final response = await _dio.post(
      ApiPath.addRole,
      data: role,
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> addUserToRole(int roleId, int userId) async {
    final response = await _dio.post(
      ApiPath.addUserToRole,
      data: {'roleId': roleId, 'userId': userId},
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deleteRole(int roleId) async {
    final response = await _dio.delete("${ApiPath.deleteRole}/$roleId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deleteUserFromRole(int roleId, int userId) async {
    final response = await _dio.delete(
      ApiPath.deleteUserFromRole,
      queryParameters: {'roleId': roleId, 'userId': userId},
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<RoleDto>> getRoleByIdWithUsers(int roleId) async {
    final response = await _dio.get('${ApiPath.getRoleByIdWithUsers}/$roleId');
    return ApiResponseDto<RoleDto>.fromJson(response.data as Map<String, dynamic>, (json) => RoleDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<RoleDto>>> getAllRole() async {
    final response = await _dio.get(ApiPath.getAllRole);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<RoleDto>>.fromJson(responseBody, (json) => json.map<RoleDto>((e) => RoleDto.fromJson(e as Map<String, dynamic>)).toList());
  }
}
