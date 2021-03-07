import 'package:shopping_list/models/unit.dart';

class Item {
  final String description;
  final double price;
  final double quantity;
  final bool purchased;
  final Unit unit;

  Item({
    required this.description,
    required this.price,
    required this.quantity,
    required this.purchased,
    required this.unit,
  });
}
