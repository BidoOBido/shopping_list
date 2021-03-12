import 'package:shopping_list/models/unit.dart';

class Item {
  late int id;
  String description;
  double price;
  double quantity;
  bool purchased;
  Unit unit;

  Item({
    required this.description,
    required this.price,
    required this.quantity,
    required this.purchased,
    required this.unit,
  });
}
