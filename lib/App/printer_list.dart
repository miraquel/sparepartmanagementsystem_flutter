import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';

class PrinterList extends StatefulWidget {
  const PrinterList({super.key});

  @override
  State<PrinterList> createState() => _PrinterListState();
}

class _PrinterListState extends State<PrinterList> {
  var _isLoading = false;
  List<BluetoothDevice> _printerList = [];
  BluetoothDevice? _selectedPrinter;
  late NavigatorState _navigator;
  final _copiesController = TextEditingController(text: '1');
  // form key
  final _formKey = GlobalKey<FormState>();

  Future<void> _getPrinterList() async {
    setState(() => _isLoading = true);
    try {
      _printerList = await FlutterBluePlus.bondedDevices;
      if (kDebugMode) {
        print('Printer List: $_printerList');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });
    _getPrinterList();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Printer List'),
          actions: [
            IconButton(
              onPressed: _selectedPrinter == null ? null : () {
                // validate form
                if (_formKey.currentState!.validate()) {
                  var arguments = <String, dynamic>{
                    'copies': int.parse(_copiesController.text),
                    'printer': _selectedPrinter,
                  };
                  _navigator.pop(arguments);
                }
              },
              icon: const Icon(Icons.print),
            ),
          ],
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  controller: _copiesController,
                  decoration: InputDecoration(
                    labelText: 'Copies',
                    hintText: 'Enter the number of copies',
                    border: const OutlineInputBorder(),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_copiesController.text.isNotEmpty) {
                              var value = int.parse(_copiesController.text);
                              if (value > 1) {
                                setState(() => _copiesController.text = (value - 1).toString());
                              }
                            }
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_copiesController.text.isNotEmpty) {
                              var value = int.parse(_copiesController.text);
                              setState(() => _copiesController.text = (value + 1).toString());
                            }
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ),
                  keyboardType: TextInputType.number,
                  // validate the number must be greater than 0
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of copies';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a number greater than 0';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _printerList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (_selectedPrinter == _printerList[index]) {
                        setState(() => _selectedPrinter = null);
                      }
                      else {
                        setState(() => _selectedPrinter = _printerList[index]);
                      }
                    },
                    title: Text(_printerList[index].platformName),
                    subtitle: Text(_printerList[index].remoteId.toString()),
                    trailing: _selectedPrinter == _printerList[index]
                        ? const Icon(Icons.check)
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
