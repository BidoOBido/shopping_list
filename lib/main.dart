import 'package:flutter/material.dart';
import 'package:shopping_list/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/provider/items.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemsProvider(),
        )
      ],
      child: ShoppingList(),
    ),
  );
}

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext? context) {
    return MaterialApp(
      initialRoute: Routes.initialRoute,
      routes: Routes.routesMap,
    );
  }
}
