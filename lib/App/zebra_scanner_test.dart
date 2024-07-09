import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';

class ZebraScannerTest extends StatefulWidget {
  const ZebraScannerTest({super.key});

  @override
  State<ZebraScannerTest> createState() => _ZebraScannerTestState();
}

class _ZebraScannerTestState extends State<ZebraScannerTest> with SingleTickerProviderStateMixin {
  late ScaffoldMessengerState scaffoldMessenger;
  late NavigatorState navigator;
  var scanText = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scaffoldMessenger = ScaffoldMessenger.of(context);
      navigator = Navigator.of(context);
    });

    // Zebra scanner device
    if (Platform.isAndroid)
    {
      Environment.zebraMethodChannel.invokeMethod("registerReceiver");
      Environment.zebraMethodChannel.setMethodCallHandler((call) async {
        if (call.method == "displayScanResult") {
          var scanData = call.arguments["scanData"];
          setState(() => scanText = scanData);
        }
        if (call.method == "showToast") {
          scaffoldMessenger.showSnackBar(SnackBar(
            content: Text(call.arguments as String),
          ));
        }
        return null;
      });
    }
    // end - Zebra scanner device
  }

  @override
  void dispose() {
    Environment.zebraMethodChannel.invokeMethod("unregisterReceiver");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zebra Scanner Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Test the Zebra scanner here."),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Environment.zebraMethodChannel.invokeMethod("toggleSoftScan");
              },
              child: const Text("Start scan"),
            ),
            const SizedBox(height: 16),
            Text("Scan result: $scanText"),
          ],
        ),
      ),
    );
  }
}
