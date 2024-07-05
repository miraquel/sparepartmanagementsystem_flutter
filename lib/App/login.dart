import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/App/reconnect.dart';
import 'package:sparepartmanagementsystem_flutter/App/status_bar.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/token_helper.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

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
      var login = await _userDAL.loginWithActiveDirectory(_usernameController.text, _passwordController.text);
      if (login.data != null) {
        await TokenHelper.writeTokenLocally(login.data!.accessToken, login.data!.refreshToken);
        var userId = getUserIdFromToken(login.data?.accessToken);
        await _storage.write(key: 'userId', value: userId);
        await _navigator.pushReplacementNamed('/home');
      }
    } on DioException catch (e) {
      if (e.response?.data['errorMessages'] is List) {
        var message = e.response?.data['errorMessages'] as List<dynamic>;
        _scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(message.first),
          ),
        );
      } else if (e.response?.data['errorMessages'] is String) {
        var message = e.response?.data['errorMessages'] as String;
        _scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
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
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // show logo of the app_logo.png
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Center(
                            child: Image.asset(
                              'assets/images/app_logo_samson.png',
                              height: 200,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        const FittedBox(
                          child: Text(
                            'Welcome to Spare Part Management System Online',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            minimumSize: const Size.fromHeight(55)
                          ),
                          child: const Text('Login', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 0,
                child: StatusBar(editMode: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
