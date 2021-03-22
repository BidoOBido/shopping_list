import 'package:flutter/material.dart';
import 'package:shopping_list/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/provider/items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      initialRoute: Routes.initialRoute,
      routes: Routes.routesMap,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
