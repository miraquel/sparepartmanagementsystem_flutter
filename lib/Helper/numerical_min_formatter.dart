import 'package:flutter/services.dart';

class NumericalMinFormatter extends TextInputFormatter {
  final double min;

  NumericalMinFormatter({required this.min});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue)
  {

    if (newValue.text == '') {
      return newValue;
    } else {
      return int.parse(newValue.text) < min ? const TextEditingValue().copyWith(text: min.toStringAsFixed(2)) : newValue;
    }
  }
}