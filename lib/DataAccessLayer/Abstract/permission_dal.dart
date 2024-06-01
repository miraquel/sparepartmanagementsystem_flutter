import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/permission_dto.dart';

abstract class PermissionDAL {
  Future<ApiResponseDto<List<PermissionDto>>> getAllPermission();
  Future<ApiResponseDto<List<PermissionDto>>> getPermissionByRoleId(int roleId);
  Future<ApiResponseDto<List<PermissionDto>>> getAllPermissionType();
  Future<ApiResponseDto<List<PermissionDto>>> getAllModules();
  Future<ApiResponseDto> addPermission(PermissionDto permission);
  Future<ApiResponseDto> deletePermission(int permissionId);
}