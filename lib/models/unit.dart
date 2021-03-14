import 'package:intl/intl.dart';

class Unit {
  final String description;
  final String abbreviation;
  final int decimalPlaces;

  Unit({
    required this.description,
    required this.abbreviation,
    required this.decimalPlaces,
  });

  String formatQuantity(double value) {
    NumberFormat _quantityFormatter = NumberFormat.currency(
      decimalDigits: decimalPlaces,
      symbol: '',
    );

    return _quantityFormatter.format(value);
  }
}
