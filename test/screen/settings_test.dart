import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/constants/i18n.dart';
import 'package:shopping_list/constants/l10n.dart';
import 'package:shopping_list/screens/settings.dart';

void main() {
  testWidgets(
    "Find test screen",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Localizations(
          delegates: L10n.delegates,
          locale: I18N.suportedLocales.first,
          child: Settings(),
        ),
      );

      final titleFinder = find.text("Settings");

      expect(titleFinder, findsNothing);
    },
  );
}
