import 'package:flutter/widgets.dart';
import 'package:shopping_list/models/menu_item.dart';
import 'package:shopping_list/screens/shopping_list_items.dart';
import 'package:shopping_list/screens/item.dart';
import 'package:shopping_list/screens/settings.dart';

class Routes {
  static const String shoppingListItemsRoute = '/shoppingListItems';
  static const String settingsRoute = '/settings';
  static const String itemsRoute = '/items';

  static final Map<String, Widget Function(BuildContext)> routesMap = {
    shoppingListItemsRoute: (context) => ShoppingListItems(),
    settingsRoute: (context) => Settings(),
    itemsRoute: (context) => RegisterItem(),
  };

  static final menuRoutes = [
    MenuItem('ShoppingListItemsHeader', shoppingListItemsRoute),
    MenuItem('SettingsHeader', settingsRoute),
  ];

  static const String initialRoute = shoppingListItemsRoute;
}
