import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';

class ZebraScannerSettings extends StatefulWidget {
  const ZebraScannerSettings({super.key});

  @override
  State<ZebraScannerSettings> createState() => _ZebraScannerSettingsState();
}

class _ZebraScannerSettingsState extends State<ZebraScannerSettings> {
  late NavigatorState _navigator;
  var _code128 = false;
  var _code39 = false;
  var _ean13 = false;
  var _upca = false;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _navigator = Navigator.of(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Zebra Scanner Settings'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Settings for the Zebra scanner will be available here."),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        Environment.zebraMethodChannel.invokeMethod("createProfile");
                        setState(() => _isLoading = false);
                      },
                      child: const Text("Create profile"),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Code-128'),
                      value: _code128,
                      onChanged: (value) {
                        setState(() {
                          _code128 = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Code-39'),
                      value: _code39,
                      onChanged: (value) {
                        setState(() {
                          _code39 = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('EAN-13'),
                      value: _ean13,
                      onChanged: (value) {
                        setState(() {
                          _ean13 = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('UPCA'),
                      value: _upca,
                      onChanged: (value) {
                        setState(() {
                          _upca = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var scaffoldMessenger = ScaffoldMessenger.of(context);
                        var result = await Environment.zebraMethodChannel.invokeMethod("setDecoder", {
                          "code128": _code128,
                          "code39": _code39,
                          "ean13": _ean13,
                          "upca": _upca,
                        });
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text(result.toString()),
                          ),
                        );
                      },
                      child: const Text("Set selected decoder"),
                    ),
                    ElevatedButton(
                      onPressed: () async => await _navigator.pushNamed('/zebraScannerTest'),
                      child: const Text("Test scanner"),
                    )
                  ],
                )
            )
        )
    );
  }
}
