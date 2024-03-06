import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/role_dto.dart';

abstract class RoleDAL {
  Future<ApiResponseDto<List<RoleDto>>> fetchRole();
  Future<ApiResponseDto<List<RoleDto>>> deleteRole(int roleId);
  Future<ApiResponseDto<RoleDto>> addRole(RoleDto role);
  Future<ApiResponseDto<RoleDto>> fetchByIdWithUsers(int roleId);
  Future<ApiResponseDto<RoleDto>> addUserToRole(int roleId, int userId);
  Future<ApiResponseDto<RoleDto>> deleteUserFromRole(int roleId, int userId);
}