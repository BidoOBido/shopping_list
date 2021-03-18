import 'package:flutter/material.dart';
import 'package:shopping_list/components/app_localizations.dart';
import 'package:shopping_list/components/base/screen.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      headerTitle: AppLocalizations.of(context)!.translate('SettingsHeader'),
      body: Center(
        child: Text("There's no settings yet"),
      ),
    );
  }
}
