import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  TokenHelper._();

  static Future<void> writeTokenLocally(String accessToken, String? refreshToken) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'accessToken', value: accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await storage.write(key: 'refreshToken', value: refreshToken);
    }
  }
}