import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import '../../Model/ActiveDirectoryDto.dart';
import '../../Model/api_response_dto.dart';
import '../../Model/refresh_token_dto.dart';
import '../../Model/token_dto.dart';
import '../../Model/user_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/user_dal.dart';
import '../api_path.dart';

const storage = FlutterSecureStorage();

class UserDALImplementation implements UserDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<TokenDto>> loginWithActiveDirectory(String username, String password) async {
    final response = await _dio.post(ApiPath.loginWithActiveDirectory, data: {'username': username, 'password': password});
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto<TokenDto>.fromJson(body, (json) => TokenDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> getUserByIdWithRoles(int userId) async {
    final response = await _dio.get('${ApiPath.getUserByIdWithRoles}/$userId');
    Map<String, dynamic> body = response.data;
    return ApiResponseDto<UserDto>.fromJson(body, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> getUserByUsernameWithRoles() async {
    var username = await storage.read(key: 'username');
    final response = await _dio.get(
      ApiPath.getUserByUsernameWithRoles,
      queryParameters: {'username': username},
    );
    Map<String, dynamic> body = response.data;
    return ApiResponseDto<UserDto>.fromJson(body, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<UserDto>>> getUser() async {
    final response = await _dio.get(
      ApiPath.getUser,
    );
    return ApiResponseDto<List<UserDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => json.map<UserDto>((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<UserDto>> getUserById(int id) async {
    final response = await _dio.get('${ApiPath.getUserById}/$id');
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<UserDto>.fromJson(responseBody, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto> deleteUser(int userId) async {
    final response = await _dio.delete("${ApiPath.deleteUser}/$userId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> addUser(UserDto user) async {
    final response = await _dio.post(
      ApiPath.addUser,
      data: user,
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> addRoleToUser(int userId, int roleId) async {
    var response = await _dio.post(
      ApiPath.addRoleToUser,
      data: {'userId': userId, 'roleId': roleId},
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deleteRoleFromUser(int userId, int roleId) async {
    final response = await _dio.delete(
      ApiPath.deleteRoleFromUser,
      queryParameters: {'userId': userId, 'roleId': roleId},
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<ActiveDirectoryDto>>> getUsersFromActiveDirectory([String searchText = ""]) async {
    var queryParameters = {'searchText': searchText};
    final response = await _dio.get(
      ApiPath.getUsersFromActiveDirectory,
      queryParameters: queryParameters,
    );

    return ApiResponseDto<List<ActiveDirectoryDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => json.map<ActiveDirectoryDto>((e) => ActiveDirectoryDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto> updateUser(UserDto user) async {
    final response = await _dio.put(
      ApiPath.updateUser,
      data: user,
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<TokenDto>> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      ApiPath.refreshToken,
      data: {'refreshToken': refreshToken},
    );
    Map<String, dynamic> body = jsonDecode(response.toString()) as Map<String, dynamic>;
    return ApiResponseDto<TokenDto>.fromJson(body, (json) => TokenDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<RefreshTokenDto>> revokeToken(RefreshTokenDto refreshToken) async {
    final response = await _dio.post(
      ApiPath.revokeToken,
      data: refreshToken,
    );
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto<RefreshTokenDto>.fromJson(body, (json) => RefreshTokenDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<RefreshTokenDto>>> revokeAllTokens(RefreshTokenDto refreshToken) async {
    final response = await _dio.post(
      ApiPath.revokeAllTokens,
      data: refreshToken,
    );
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<RefreshTokenDto>>.fromJson(
        body, (json) => json.map<UserDto>((e) => RefreshTokenDto.fromJson(e as Map<String, dynamic>)).toList());
  }
}
