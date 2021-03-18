import 'package:flutter/material.dart';

class I18N {
  static const suportedLocales = [
    Locale('en', 'US'),
    Locale('pt', 'BR'),
  ];

  static List<String> get supportedLanguages =>
      suportedLocales.map((e) => '${e.languageCode}_${e.countryCode}').toList();
}
