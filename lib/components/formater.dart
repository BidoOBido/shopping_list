import 'package:intl/intl.dart';

class Formater {
  static NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    decimalDigits: 2,
    symbol: '',
  );

  static String formatCurrency(double value) {
    return _currencyFormatter.format(value);
  }
}
