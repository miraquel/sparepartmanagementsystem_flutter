import 'package:sparepartmanagementsystem_flutter/Model/active_directory_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/token_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/refresh_token_dto.dart';

abstract class UserDAL {
  Future<ApiResponseDto<TokenDto>> loginWithActiveDirectory(String username, String password);
  Future<ApiResponseDto<UserDto>> getUserByIdWithRoles(int userId);
  Future<ApiResponseDto<UserDto>> getUserByUsernameWithRoles(String username);
  Future<ApiResponseDto<List<UserDto>>> getUser();
  Future<ApiResponseDto<UserDto>> getUserById(int id);
  Future<ApiResponseDto> deleteUser(int userId);
  Future<ApiResponseDto> addUser(UserDto user);
  Future<ApiResponseDto> addRoleToUser(int userId, int roleId);
  Future<ApiResponseDto> deleteRoleFromUser(int userId, int roleId);
  Future<ApiResponseDto<List<ActiveDirectoryDto>>> getUsersFromActiveDirectory([String searchText = ""]);
  Future<ApiResponseDto> updateUser(UserDto user);
  Future<ApiResponseDto<TokenDto>> refreshToken(String refreshToken);
  Future<ApiResponseDto> revokeToken(RefreshTokenDto refreshToken);
  Future<ApiResponseDto> revokeAllTokens(RefreshTokenDto refreshToken);
  Future<ApiResponseDto<UserDto>> getUserByIdWithUserWarehouse(int userId);
}