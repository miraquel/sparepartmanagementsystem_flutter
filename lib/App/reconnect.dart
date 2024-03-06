// create a modal dialog to reconnect if network is lost

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Reconnect extends StatelessWidget {
  final Function reconnect;
  final _storage = const FlutterSecureStorage();
  const Reconnect({super.key, required this.reconnect});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: const Text('Network Error'),
        content: const Text('Please check your network connection and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              reconnect();
            },
            child: const Text('Reconnect'),
          ),
          // logout button
          TextButton(
            onPressed: () {
              _storage.deleteAll();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
