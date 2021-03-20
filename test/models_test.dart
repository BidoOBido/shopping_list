import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/unit.dart';

main() {
  group(
    'normal tests',
    () {
      test(
        'Should return informed quantity',
        () {
          Unit originalUnit = Unit(
            description: 'Unit1',
            abbreviation: 'Un1',
            decimalPlaces: 0,
          );
          Item originalItem = Item(
            description: 'Product1',
            price: 2.35,
            quantity: 1,
            purchased: false,
            unit: originalUnit,
          );

          expect(originalItem.formatQuantity(), '1');
        },
      );

      test(
        'Should return informed quantity',
        () {
          Unit originalUnit = Unit(
            description: 'Unit1',
            abbreviation: 'Un1',
            decimalPlaces: 2,
          );
          Item originalItem = Item(
            description: 'Product1',
            price: 2.35,
            quantity: 1.33,
            purchased: false,
            unit: originalUnit,
          );

          expect(originalItem.formatQuantity(), '1.33');
        },
      );
    },
  );
  group(
    'exception tests',
    () {
      test(
        'Should return AssertionError on unit create',
        () => expect(
          () => Unit(
            description: 'Unit1',
            abbreviation: 'Un1',
            decimalPlaces: -1,
          ),
          throwsAssertionError,
        ),
      );
      test(
        'Should return AssertionError on Item create caused by quantity = 0',
        () {
          Unit originalUnit = Unit(
            description: 'Unit1',
            abbreviation: 'Un1',
            decimalPlaces: 0,
          );
          expect(
            () => Item(
              description: 'Product1',
              price: 2.35,
              quantity: 0,
              purchased: false,
              unit: originalUnit,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'Should return AssertionError on Item create caused by incorrect decimal places (0 to 3)',
        () {
          Unit originalUnit = Unit(
            description: 'Unit1',
            abbreviation: 'Un1',
            decimalPlaces: 0,
          );

          expect(
            () => Item(
              description: 'Product1',
              price: 2.35,
              quantity: 1.333,
              purchased: false,
              unit: originalUnit,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'Should return AssertionError on Item create caused by incorrect decimal places (2 to 3)',
        () {
          Unit originalUnit = Unit(
            description: 'Unit1',
            abbreviation: 'Un1',
            decimalPlaces: 2,
          );

          expect(
            () => Item(
              description: 'Product1',
              price: 2.35,
              quantity: 1.333,
              purchased: false,
              unit: originalUnit,
            ),
            throwsAssertionError,
          );
        },
      );
    },
  );
}
