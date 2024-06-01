import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/App/reconnect.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/token_helper.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/token_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';

class DioLoggingInterceptors extends Interceptor {
  final logger = locator<Logger>();
  final Dio _dio;
  final storage = const FlutterSecureStorage();
  final GlobalKey<NavigatorState> navigatorKey;

  DioLoggingInterceptors(this._dio, {required this.navigatorKey});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If the response status code is 401 (Unauthorized), attempt to refresh the token
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      try {
        // Add your logic to refresh the token
        var refreshTokenLocal = await storage.read(key: 'refreshToken');

        var dio = Dio();
        dio.options = _dio.options;
        dio.options.baseUrl = Environment.baseUrl;
        var refreshTokenResponse = await dio.post(ApiPath.refreshToken, data: { 'refreshToken': refreshTokenLocal });

        ApiResponseDto<TokenDto> refreshToken = ApiResponseDto.fromJson(refreshTokenResponse.data, (json) => TokenDto.fromJson(json));
        // Save the new tokens for next time
        await TokenHelper.writeTokenLocally(refreshToken.data!.accessToken, refreshToken.data!.refreshToken);

        // Update the access token in the headers
        err.requestOptions.headers["Authorization"] = "Bearer ${refreshToken.data!.accessToken}";

        // Retry the original request
        var retryResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      } on DioException catch (error) {
        if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return Reconnect(
                reconnect: () => _dio.fetch(err.requestOptions),
              );
            },
          );
        }

        err = error;
      }
    }

    if (err.response?.statusCode == 400 || err.response?.statusCode == 500) {
      // create a safe conversion of error response data to ApiResponseDto
      try {
        var errorResponse = ApiResponseDto.fromJson(err.response?.data, (json) => json);
        var snackBar = SnackBar(
          content: Text(errorResponse.errorMessages.first),
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
        logger.e(errorResponse.errorMessages.join());
      } catch (e) {
        logger.e(err.response?.data);
      }

      return handler.reject(err);
    }

    if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
      // if it is not in the login page, redirect to login page
      var currentRoute = routeObserver.currentRoute;
      if (currentRoute != '/') {
        navigatorKey.currentState?.pushReplacementNamed('/');
      }
      return handler.reject(err);
    }

    // For other errors, simply propagate the error
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(response.data);
    return handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await storage.read(key: 'accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    options.baseUrl = Environment.baseUrl;
    handler.next(options);
  }

  Future showReconnectDialog(Function reconnect) async {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Reconnect(
          reconnect: reconnect
        );
      },
    );
  }
}