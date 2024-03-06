import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import '../../Model/permission_dto.dart';

abstract class PermissionDAL {
  Future<ApiResponseDto<List<PermissionDto>>> fetchPermission();
  Future<ApiResponseDto<List<PermissionDto>>> fetchPermissionByRoleId(int roleId);
  Future<ApiResponseDto<List<PermissionDto>>> fetchAllPermissionType();
  Future<ApiResponseDto<List<PermissionDto>>> fetchAllModule();
  Future<ApiResponseDto<PermissionDto>> addPermission(PermissionDto permission);
  Future<ApiResponseDto<PermissionDto>> deletePermission(int permissionId);
}