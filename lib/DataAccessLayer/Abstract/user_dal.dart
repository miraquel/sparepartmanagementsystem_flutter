import 'package:sparepartmanagementsystem_flutter/Model/ActiveDirectoryDto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/token_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/refresh_token_dto.dart';

abstract class UserDAL {
  Future<ApiResponseDto<TokenDto>> loginWithActiveDirectory(String username, String password);
  Future<ApiResponseDto<UserDto>> getUserByIdWithRoles(int userId);
  Future<ApiResponseDto<UserDto>> getUserByUsernameWithRoles();
  Future<ApiResponseDto<List<UserDto>>> getUser();
  Future<ApiResponseDto<UserDto>> getUserById(int id);
  Future<ApiResponseDto> deleteUser(int userId);
  Future<ApiResponseDto> addUser(UserDto user);
  Future<ApiResponseDto> addRoleToUser(int userId, int roleId);
  Future<ApiResponseDto> deleteRoleFromUser(int userId, int roleId);
  Future<ApiResponseDto<List<ActiveDirectoryDto>>> getUsersFromActiveDirectory([String searchText = ""]);
  Future<ApiResponseDto> updateUser(UserDto user);
  Future<ApiResponseDto<TokenDto>> refreshToken(String refreshToken);
  Future<ApiResponseDto<RefreshTokenDto>> revokeToken(RefreshTokenDto refreshToken);
  Future<ApiResponseDto<List<RefreshTokenDto>>> revokeAllTokens(RefreshTokenDto refreshToken);
}