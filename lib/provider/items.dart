import 'package:flutter/widgets.dart';
import 'package:shopping_list/models/item.dart';

class ItemsProvider with ChangeNotifier {
  List<Item> _items = List<Item>.empty(growable: true);
  double _total = 0.0;

  List<Item> get items => _items;
  double get total => double.parse((_total).toStringAsFixed(2));

  void updateTotal(Item value, bool reduce) {
    _total += (reduce ? -1 : 1) * (value.price * value.quantity);
  }

  void add(Item value) {
    _items.add(value);

    updateTotal(_items.last, false);

    notifyListeners();
  }

  void remove(Item value) {
    updateTotal(value, true);

    _items.remove(value);

    notifyListeners();
  }

  void removeAt(int index) {
    updateTotal(_items.removeAt(index), true);

    notifyListeners();
  }

  Item pop() {
    Item returnItem = _items.removeLast();

    updateTotal(returnItem, true);

    notifyListeners();

    return returnItem;
  }

  void changePurchase(Item item, bool? value) {
    item.purchased = value ?? false;

    notifyListeners();
  }

  Item update(int index, Item updatedItem) {
    Item returnItem = _items[index];

    updateTotal(returnItem, true);

    returnItem = updatedItem;

    updateTotal(returnItem, false);

    _items[index] = returnItem;

    notifyListeners();

    return returnItem;
  }
}
