import 'package:flutter/widgets.dart';
import 'package:shopping_list/models/menu_item.dart';
import 'package:shopping_list/screens/shopping_list_items.dart';
import 'package:shopping_list/screens/item.dart';
import 'package:shopping_list/screens/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Routes {
  static const String shoppingListItemsRoute = '/shoppingListItems';
  static const String settingsRoute = '/settings';
  static const String itemsRoute = '/items';

  static final Map<String, Widget Function(BuildContext)> routesMap = {
    shoppingListItemsRoute: (context) => ShoppingListItems(),
    settingsRoute: (context) => Settings(),
    itemsRoute: (context) => RegisterItem(),
  };

  static List<MenuItem> menuRoutes(BuildContext context) {
    return [
      MenuItem(AppLocalizations.of(context)!.shoppingListItemsHeader,
          shoppingListItemsRoute),
      MenuItem(AppLocalizations.of(context)!.settingsHeader, settingsRoute),
    ];
  }

  static const String initialRoute = shoppingListItemsRoute;
}
