import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/refresh_token_dto.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class AuthHelper {
  AuthHelper._();

  // Logout
  static Future<void> logout() async {
    final userDAL = locator<UserDAL>();
    const storage = FlutterSecureStorage();
    final refreshToken = await storage.read(key: 'refreshToken');
    if (refreshToken != null && refreshToken.isNotEmpty) {
      var refreshTokenDto = RefreshTokenDto(token: refreshToken);
      await userDAL.revokeToken(refreshTokenDto);
    }
    await storage.delete(key: 'userId');
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');

    // clear user warehouse dto
    Environment.clearUserWarehouseDto();
  }
}