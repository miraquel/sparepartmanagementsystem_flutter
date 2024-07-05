import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:sparepartmanagementsystem_flutter/App/confirmation_dialog.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class StatusBar extends StatefulWidget {
  final bool editMode;
  const StatusBar({
    super.key, this.editMode = false,
  });

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: !widget.editMode ? null : () async {
              var valid = await showDialog<bool>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return const MasterKeyDialog();
                },
              );
              if (valid == true) {
                await showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return const BaseUrlDialog();
                  },
                );
              }
              setState(() => Environment.baseUrl);
            },
            child: Text(
              Environment.baseUrl,
              style: TextStyle(
                color: Colors.white,
                decoration: widget.editMode ? TextDecoration.underline : TextDecoration.none,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: Colors.white,
                decorationThickness: 1.5,
              ),
            ),
          ),
          Text(
            "v${Environment.version}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// dialog to ask for a master key
class MasterKeyDialog extends StatefulWidget {
  const MasterKeyDialog({
    super.key,
  });

  @override
  State<MasterKeyDialog> createState() => _MasterKeyDialogState();
}

class _MasterKeyDialogState extends State<MasterKeyDialog> {
  final _masterKeyController = TextEditingController();
  late NavigatorState _navigator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });
  }

  bool _validateMasterKey() {
    final otp = OTP.generateTOTPCodeString(Environment.masterSecretKey, DateTime.now().millisecondsSinceEpoch, interval: 30, length: 6, algorithm: Algorithm.SHA1, isGoogle: true);
    return OTP.constantTimeVerification(otp, _masterKeyController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Master Key'),
      content: TextField(
        controller: _masterKeyController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Enter master key',
        ),
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => _navigator.pop(false),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () async {
            if (_validateMasterKey()) {
              _navigator.pop(true);
            }
            else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid master key'),
                ),
              );
              _navigator.pop(false);
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}

// dialog to ask for base Url
class BaseUrlDialog extends StatefulWidget {
  const BaseUrlDialog({
    super.key,
  });

  @override
  State<BaseUrlDialog> createState() => _BaseUrlDialogState();
}

class _BaseUrlDialogState extends State<BaseUrlDialog> {
  final _baseUrlController = TextEditingController(text: Environment.baseUrl);
  late NavigatorState _navigator;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: AlertDialog(
        title: const Text('Parameters'),
        // multi-line text field to enter base URL
        content: TextField(
          controller: _baseUrlController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Enter base URL',
            border: OutlineInputBorder(),
            label: Text('Base URL'),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _navigator.pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await showDialog(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ConfirmationDialog(
                    title: const Text('Reset Base URL'),
                    content: const Text('Are you sure you want to reset the base URL?'),
                    onConfirm: () async {
                      await Environment.clearBaseUrl();
                      setState(() => _baseUrlController.text = Environment.baseUrl);
                    },
                  );
                },
              );
              _navigator.pop();
            },
            child: const Text('Reset'),
          ),
          TextButton(
            onPressed: () async {
              setState(() => _isLoading = true);
              await Environment.saveBaseUrl(_baseUrlController.text);
              setState(() => _isLoading = false);
              _navigator.pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}