import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';

import 'package:sparepartmanagementsystem_flutter/App/shimmer.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/auth_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/user_dto.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/user_dal.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _storage = const FlutterSecureStorage();
  final _userDAL = locator<UserDAL>();
  final _logger = locator<Logger>();
  bool _isLoading = false;
  bool _isWaitingLogout = false;
  UserDto _user = UserDto();
  late final NavigatorState _navigator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });

    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => _isLoading = true);
    try {
      var userIdString = await _storage.read(key: 'userId');
      if (userIdString == null) {
        throw Exception('User ID not found');
      }
      var userId = int.parse(userIdString);
      var fetchUser = await _userDAL.getUserById(userId);
      if (fetchUser.success && fetchUser.data != null) {
        setState(() => _user = fetchUser.data!);
      }
    } catch (e) {
      _logger.e('Error while fetching data', error: e);
    }
    finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      //backgroundColor: Colors.grey[200],
      body: LoadingOverlay(
        isLoading: _isWaitingLogout,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  masthead(),
                  const SizedBox(height: 20),
                  content(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Username', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: ShimmerLoading(
              isLoading: _isLoading,
              shimmerChild: Container(
                width: 250,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text(
                _user.username,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.person, size: 25)
            ),
            minLeadingWidth: 0,
          ),
          ListTile(
            title: const Text('Email', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: ShimmerLoading(
              isLoading: _isLoading,
              shimmerChild: Container(
                width: 200,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                _user.email,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.email, size: 25)
            ),
            minLeadingWidth: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/adminCenter');
            },
            title: const Text('Admin Center'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.key, size: 25)
            ),
            minLeadingWidth: 0,
          ),
          // logout button
          ListTile(
            onTap: () async {
              setState(() => _isWaitingLogout = true);
              await AuthHelper.logout();
              setState(() => _isWaitingLogout = false);
              await _navigator.pushReplacementNamed('/');
            },
            title: const Text('Logout'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.logout, size: 25)
            ),
            minLeadingWidth: 0,
          ),
        ],
      ),
    );
  }

  Widget masthead() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          ShimmerLoading(
            isLoading: _isLoading,
            shimmerChild: const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/user_profile.png'),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerLoading(
                  isLoading: _isLoading,
                  shimmerChild: Container(
                    width: 200,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Text(
                    "${_user.firstName} ${_user.lastName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ShimmerLoading(
                  isLoading: _isLoading,
                  shimmerChild: Container(
                    width: 150,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    _user.email,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white
                    )
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
