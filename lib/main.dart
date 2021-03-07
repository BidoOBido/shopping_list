import 'package:flutter/material.dart';
import 'package:shopping_list/constants/routes.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(
    ShoppingList(),
    // Below is the example how to use providers instead of stateful widget
    // MultiProvider(
    //   providers: [],
    //   child: ShoppingList(),
    // ),
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
