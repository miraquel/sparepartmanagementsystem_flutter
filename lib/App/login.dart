import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/App/reconnect.dart';

import '../DataAccessLayer/Abstract/user_dal.dart';
import '../Helper/token_helper.dart';
import '../service_locator_setup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userDAL = locator<UserDAL>();
  final _logger = locator<Logger>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  var _isLoading = false;
  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffoldMessenger;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _navigator = Navigator.of(context);
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });
    validateToken();
  }

  Future<void> validateToken() async {
    try {
      setState(() => _isLoading = true);
      var refreshToken = await _storage.read(key: 'refreshToken');
      // validate not null and not blank
      if (refreshToken != null && refreshToken.isNotEmpty) {
        var response = await _userDAL.refreshToken(refreshToken);
        if (response.data != null) {
          await TokenHelper.writeTokenLocally(response.data!.accessToken, response.data!.refreshToken);
          _navigator.pushReplacementNamed('/home');
          _scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Auto logged in'),
            ),
          );
        }
      }
      // catch DioException
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        showReconnectDialog();
      }
      _logger.e('Error while validating token', error: e);
    } finally {
      if (_isLoading) {
        setState(() => _isLoading = false);
      }
    }
  }

  void showReconnectDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Reconnect(
          reconnect: () {
            validateToken();
          },
        );
      },
    );
  }

  Future<void> login() async {
    try {
      setState(() => _isLoading = true);
      var login = await _userDAL.loginWithActiveDirectory(
          _usernameController.text, _passwordController.text);
      if (login.data != null) {
        await TokenHelper.writeTokenLocally(login.data!.accessToken, login.data!.refreshToken);
        var userId = getUserIdFromToken(login.data?.accessToken);
        await _storage.write(key: 'userId', value: userId);
        _navigator.pushReplacementNamed('/home');
      }
    } catch (e) {
      _logger.e('Error while logging in', error: e);
    } finally {
      if (_isLoading) {
        setState(() => _isLoading = false);
      }
    }
  }

  String getUserIdFromToken(String? token) {
    var base64Payload = token?.split('.')[1];
    var base64UrlNormalized = base64Url.normalize(base64Payload!);
    var base64UrlString = base64Url.decode(base64UrlNormalized);
    var payloadString = utf8.decode(base64UrlString);
    var payloadJson = jsonDecode(payloadString);
    return payloadJson['userid'];
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Welcome to Spare Part Management System',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Please login to start',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
