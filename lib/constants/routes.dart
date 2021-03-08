import 'package:flutter/widgets.dart';
import 'package:shopping_list/models/menu_item.dart';
import 'package:shopping_list/screens/home.dart';
import 'package:shopping_list/screens/item.dart';
import 'package:shopping_list/screens/settings.dart';

class Routes {
  static const String homeRoute = '/';
  static const String settingsRoute = '/settings';
  static const String itemsRoute = '/items';

  static final Map<String, Widget Function(BuildContext)> routesMap = {
    homeRoute: (context) => Home(),
    settingsRoute: (context) => Settings(),
    itemsRoute: (context) => RegisterItem(),
  };

  static final menuRoutes = [
    MenuItem('Home', homeRoute),
    MenuItem('Settings', settingsRoute),
  ];

  static const String initialRoute = homeRoute;
}
