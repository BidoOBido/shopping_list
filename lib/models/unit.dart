class Unit {
  final String description;
  final String abbreviation;
  final int decimalPlaces;

  Unit({
    required this.description,
    required this.abbreviation,
    required this.decimalPlaces,
  }) : assert(decimalPlaces >= 0);
}
