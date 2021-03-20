import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatCurrency(double value, Locale locale) {
    NumberFormat _currencyFormatter = NumberFormat.currency(
      locale: locale.toString(),
      decimalDigits: 2,
      symbol: '',
    );

    return _currencyFormatter.format(value);
  }
}
