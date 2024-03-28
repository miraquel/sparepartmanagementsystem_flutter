import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/role_dto.dart';

abstract class RoleDAL {
  Future<ApiResponseDto<List<RoleDto>>> fetchRole();
  Future<ApiResponseDto> deleteRole(int roleId);
  Future<ApiResponseDto> addRole(RoleDto role);
  Future<ApiResponseDto<RoleDto>> fetchByIdWithUsers(int roleId);
  Future<ApiResponseDto> addUserToRole(int roleId, int userId);
  Future<ApiResponseDto> deleteUserFromRole(int roleId, int userId);
}