
import 'package:intl/intl.dart';

String numberToIdr(dynamic number, int decimalDigits) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp.',
    decimalDigits: decimalDigits,
  );
  return currencyFormatter.format(number);
}