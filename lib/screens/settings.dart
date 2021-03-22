import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list/components/base/screen.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      headerTitle: AppLocalizations.of(context)!.settingsHeader,
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.theresNoSettingsYet,
        ),
      ),
    );
  }
}
