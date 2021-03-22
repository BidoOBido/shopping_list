import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list/screens/settings.dart';

void main() {
  testWidgets(
    "Find test screen",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Localizations(
          delegates: AppLocalizations.localizationsDelegates,
          locale: AppLocalizations.supportedLocales.first,
          child: Settings(),
        ),
      );

      final titleFinder = find.text("Settings");

      expect(titleFinder, findsNothing);
    },
  );
}
