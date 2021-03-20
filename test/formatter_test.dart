import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/components/formatter.dart';

void main() {
  const Locale _en_US_locale = Locale('en_US');
  const Locale _pt_BR_locale = Locale('pt_BR');
  const String non_breaking_space = '\u00A0';

  group('en_US locale', () {
    group(
      'positive values',
      () {
        test(
          'Should format 5.33 to en_US 5.33',
          () => expect(Formatter.formatCurrency(5.33, _en_US_locale), '5.33'),
        );

        test(
          'Should format 1000.35 to en_US 1000.35',
          () => expect(
              Formatter.formatCurrency(1000.35, _en_US_locale), '1,000.35'),
        );
      },
    );

    group(
      'negative values',
      () {
        test(
          'Should format -5.33 to en_US -5.33',
          () => expect(Formatter.formatCurrency(-5.33, _en_US_locale), '-5.33'),
        );

        test(
          'Should format -1000.35 to en_US -1000.35',
          () => expect(
              Formatter.formatCurrency(-1000.35, _en_US_locale), '-1,000.35'),
        );
      },
    );
  });

  group('pt_BR locale', () {
    group(
      'positive values',
      () {
        test(
          'Should format 5.33 to pt_BR 5,33',
          () => expect(Formatter.formatCurrency(5.33, _pt_BR_locale),
              '${non_breaking_space}5,33'),
        );

        test(
          'Should format 1000.35 to pt_BR 1000,35',
          () => expect(Formatter.formatCurrency(1000.35, _pt_BR_locale),
              '${non_breaking_space}1.000,35'),
        );
      },
    );

    group(
      'negative values',
      () {
        test(
          'Should format -5.33 to pt_BR -5,33',
          () => expect(Formatter.formatCurrency(-5.33, _pt_BR_locale),
              '-${non_breaking_space}5,33'),
        );

        test(
          'Should format -1000.35 to pt_BR -1000,35',
          () => expect(Formatter.formatCurrency(-1000.35, _pt_BR_locale),
              '-${non_breaking_space}1.000,35'),
        );
      },
    );
  });
}
