import 'package:flutter/widgets.dart';
import 'package:shopping_list/models/item.dart';

class ItemsProvider with ChangeNotifier {
  List<Item> _items = List<Item>.empty(growable: true);
  double _total = 0.0;

  List<Item> get items => _items;
  double get total => _total;

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
}
