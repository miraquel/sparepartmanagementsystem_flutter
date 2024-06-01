import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import 'package:sparepartmanagementsystem_flutter/Model/active_directory_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/refresh_token_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/token_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';

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
  Future<ApiResponseDto<UserDto>> getUserByUsernameWithRoles(String username) async {
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
      ApiPath.getAllUser,
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
    final response = await _dio.get(
      ApiPath.getUsersFromActiveDirectory,
      queryParameters: {'searchText': searchText},
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
  Future<ApiResponseDto> revokeToken(RefreshTokenDto refreshToken) async {
    final response = await _dio.post(
      ApiPath.revokeToken,
      data: refreshToken,
    );
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(body);
  }

  @override
  Future<ApiResponseDto> revokeAllTokens(RefreshTokenDto refreshToken) async {
    final response = await _dio.post(
      ApiPath.revokeAllTokens,
      data: refreshToken,
    );
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(body);
  }

  @override
  Future<ApiResponseDto<UserDto>> getUserByIdWithUserWarehouse(int userId) async {
    final response = await _dio.get('${ApiPath.getUserByIdWithUserWarehouse}/$userId');
    return ApiResponseDto<UserDto>.fromJson(response.data, (json) => UserDto.fromJson(json));
  }
}
