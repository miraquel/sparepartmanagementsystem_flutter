import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/refresh_token_dto.dart';
import '../../Model/token_dto.dart';
import '../../Model/user_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/user_dal.dart';
import '../api_path.dart';

const storage = FlutterSecureStorage();

class UserDALImplementation implements UserDAL {
  Future<Dio> loadDio() async => await locator.getAsync<Dio>();

  @override
  Future<ApiResponseDto<TokenDto>> loginWithActiveDirectory(String username, String password) async {
    final dio = await loadDio();
    final response = await dio.post(ApiPath.loginWithActiveDirectory, data: {'username': username, 'password': password});
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto<TokenDto>.fromJson(body, (json) => TokenDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> getUserByIdWithRoles(int userId) async {
    final dio = await loadDio();
    const path = ApiPath.getUserByIdWithRoles;
    final response = await dio.get('$path/$userId');
    Map<String, dynamic> body = response.data;
    return ApiResponseDto<UserDto>.fromJson(body, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> getUserByUsernameWithRoles() async {
    final dio = await loadDio();
    var username = await storage.read(key: 'username');
    final response = await dio.get(
      ApiPath.getUserByUsernameWithRoles,
      queryParameters: {'username': username},
    );
    Map<String, dynamic> body = response.data;
    return ApiResponseDto<UserDto>.fromJson(body, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<UserDto>>> getUser() async {
    final dio = await loadDio();
    final response = await dio.get(
      ApiPath.getUser,
    );
    return ApiResponseDto<List<UserDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<UserDto>.from(json.map((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<UserDto>> getUserById(int id) async {
    final dio = await loadDio();
    const path = ApiPath.getUserById;
    final response = await dio.get('$path/$id');
    return ApiResponseDto<UserDto>.fromJson(response.data as Map<String, dynamic>, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> deleteUser(int userId) async {
    final dio = await loadDio();
    const path = ApiPath.deleteUser;
    final response = await dio.delete("$path/$userId");
    return ApiResponseDto<UserDto>.fromJson(jsonDecode(response.toString()) as Map<String, dynamic>, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> addUser(UserDto user) async {
    final dio = await loadDio();
    final response = await dio.post(
      ApiPath.addUser,
      data: user,
    );
    return ApiResponseDto<UserDto>.fromJson(response.data as Map<String, dynamic>, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> addRoleToUser(int userId, int roleId) async {
    final dio = await loadDio();
    var response = await dio.post(
      ApiPath.addRoleToUser,
      data: {'userId': userId, 'roleId': roleId},
    );
    return ApiResponseDto<UserDto>.fromJson(response.data as Map<String, dynamic>, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<UserDto>> deleteRoleFromUser(int userId, int roleId) async {
    final dio = await loadDio();
    final response = await dio.delete(
      ApiPath.deleteRoleFromUser,
      queryParameters: {'userId': userId, 'roleId': roleId},
    );
    return ApiResponseDto<UserDto>.fromJson(response.data as Map<String, dynamic>, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<UserDto>>> getUsersFromActiveDirectory() async {
    final dio = await loadDio();
    final response = await dio.get(
      ApiPath.getUsersFromActiveDirectory,
    );

    return ApiResponseDto<List<UserDto>>.fromJson(
        response.data as Map<String, dynamic>, (json) => List<UserDto>.from(json.map((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<UserDto>> updateUser(UserDto user) async {
    final dio = await loadDio();
    final response = await dio.put(
      ApiPath.updateUser,
      data: user,
    );
    return ApiResponseDto<UserDto>.fromJson(response.data as Map<String, dynamic>, (json) => UserDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<TokenDto>> refreshToken(String refreshToken) async {
    final dio = await loadDio();
    final response = await dio.post(
      ApiPath.refreshToken,
      data: {'refreshToken': refreshToken},
    );
    Map<String, dynamic> body = jsonDecode(response.toString()) as Map<String, dynamic>;
    return ApiResponseDto<TokenDto>.fromJson(body, (json) => TokenDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<RefreshTokenDto>> revokeToken(RefreshTokenDto refreshToken) async {
    final dio = await loadDio();
    final response = await dio.post(
      ApiPath.revokeToken,
      data: refreshToken,
    );
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto<RefreshTokenDto>.fromJson(body, (json) => RefreshTokenDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<RefreshTokenDto>>> revokeAllTokens(RefreshTokenDto refreshToken) async {
    final dio = await loadDio();
    final response = await dio.post(
      ApiPath.revokeAllTokens,
      data: refreshToken,
    );
    Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return ApiResponseDto<List<RefreshTokenDto>>.fromJson(
        body, (json) => List<RefreshTokenDto>.from(json.map((e) => RefreshTokenDto.fromJson(e as Map<String, dynamic>)).toList()));
  }
}
