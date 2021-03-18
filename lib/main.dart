import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_list/components/app_localizations.dart';
import 'package:shopping_list/constants/i18n.dart';
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
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)!.translate('AppName'),
      initialRoute: Routes.initialRoute,
      routes: Routes.routesMap,
      supportedLocales: I18N.suportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
