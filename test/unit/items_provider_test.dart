import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/unit.dart';
import 'package:shopping_list/provider/items.dart';

main() {
  ItemsProvider itemProvider = ItemsProvider();

  group(
    'normal tests',
    () {
      test(
        'Should begin with no item and zeroed total',
        () {
          expect(itemProvider.items.length, 0);
          expect(itemProvider.total, 0);
        },
      );
      test(
        'Should have one item and total must be 11,75',
        () {
          Unit originalUnit = Unit(
            description: 'Unit1',
            abbreviation: 'Un1',
            decimalPlaces: 0,
          );

          Item originalItem = Item(
            description: 'Product1',
            price: 2.35,
            quantity: 5,
            purchased: false,
            unit: originalUnit,
          );

          itemProvider.add(originalItem);

          Item providerItem = itemProvider.items[0];

          expect(providerItem.description, originalItem.description);
          expect(providerItem.price, originalItem.price);
          expect(providerItem.quantity, originalItem.quantity);
          expect(providerItem.purchased, originalItem.purchased);

          expect(providerItem.unit.description, originalUnit.description);
          expect(providerItem.unit.abbreviation, originalUnit.abbreviation);
          expect(providerItem.unit.decimalPlaces, originalUnit.decimalPlaces);

          expect(itemProvider.items.length, 1);
          expect(itemProvider.total, 11.75);
        },
      );

      test(
        'Should have two items and total must be 11,75',
        () {
          Unit originalUnit = Unit(
            description: 'Unit2',
            abbreviation: 'Un2',
            decimalPlaces: 2,
          );

          Item originalItem = Item(
            description: 'Product2',
            price: 0,
            quantity: 3.33,
            purchased: false,
            unit: originalUnit,
          );

          itemProvider.add(originalItem);

          Item providerItem = itemProvider.items[1];

          expect(providerItem.description, originalItem.description);
          expect(providerItem.price, originalItem.price);
          expect(providerItem.quantity, originalItem.quantity);
          expect(providerItem.purchased, originalItem.purchased);

          expect(providerItem.unit.description, originalUnit.description);
          expect(providerItem.unit.abbreviation, originalUnit.abbreviation);
          expect(providerItem.unit.decimalPlaces, originalUnit.decimalPlaces);

          expect(itemProvider.items.length, 2);
          expect(itemProvider.total, 11.75);
        },
      );

      test(
        'Should update price on item 2, total must be now ',
        () {
          Unit originalUnit = Unit(
            description: 'Unit2',
            abbreviation: 'Un2',
            decimalPlaces: 2,
          );

          Item originalItem = Item(
            description: 'Product2',
            price: 3.33,
            quantity: 3.33,
            purchased: false,
            unit: originalUnit,
          );

          Item providerItem = itemProvider.update(1, originalItem);

          expect(providerItem.description, originalItem.description);
          expect(providerItem.price, originalItem.price);
          expect(providerItem.quantity, originalItem.quantity);
          expect(providerItem.purchased, originalItem.purchased);

          expect(providerItem.unit.description, originalUnit.description);
          expect(providerItem.unit.abbreviation, originalUnit.abbreviation);
          expect(providerItem.unit.decimalPlaces, originalUnit.decimalPlaces);

          expect(itemProvider.items.length, 2);
          expect(itemProvider.total, 22.84);
        },
      );

      test(
        'Should purchase item',
        () {
          Item originalItem = itemProvider.pop();

          itemProvider.changePurchase(originalItem, true);
          itemProvider.add(originalItem);

          expect(itemProvider.items.last.purchased, true);
        },
      );

      test(
        'Should remove first item',
        () {
          itemProvider.removeAt(0);

          expect(itemProvider.items.length, 1);
          expect(itemProvider.total, 11.09);
        },
      );

      test(
        'Should remove last item in list',
        () {
          itemProvider.remove(itemProvider.items.last);

          expect(itemProvider.items.length, 0);
          expect(itemProvider.total, 0);
        },
      );
    },
  );
}
