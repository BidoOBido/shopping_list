import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/base/screen.dart';
import 'package:shopping_list/constants/default_units.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/unit.dart';
import 'package:shopping_list/provider/items.dart';

class RegisterItem extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    Unit unit = DefaultUnits.units[0];

    final int selectedIndex =
        int.tryParse(ModalRoute.of(context)!.settings.arguments.toString()) ??
            -1;

    return Consumer<ItemsProvider>(
      builder: (context, value, child) {
        if (selectedIndex >= 0) {
          Item item = value.items[selectedIndex];
          descriptionController.text = item.description;
          quantityController.text = item.quantity.toString();
          priceController.text = item.price.toString();
          unit = item.unit;
        }

        return ScreenBase(
          headerTitle: 'Item',
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please informe some description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      validator: (value) {
                        if (((value ?? '').isEmpty) ||
                            (double.parse(value ?? '0') < 1)) {
                          return 'Quantity must be greater than zero';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      validator: (value) {
                        if (((value ?? '').isEmpty) ||
                            (double.parse(value ?? '0') < 0)) {
                          return 'Quantity must be zero or grater';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      onChanged: (Unit? selected) => unit =
                          selected ?? Unit(description: '', decimalPlaces: 0),
                      items: DefaultUnits.units.map(
                        (Unit unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit.description),
                          );
                        },
                      ).toList(),
                      value: unit,
                      validator: (value) =>
                          value == null ? 'Please select some unit' : null,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedIndex >= 0) {
                            Item updatedItem = Item(
                                description: descriptionController.text,
                                price: double.parse(priceController.text),
                                quantity: double.parse(quantityController.text),
                                purchased: false,
                                unit: unit);

                            updatedItem.id = selectedIndex;

                            value.update(
                              selectedIndex,
                              updatedItem,
                            );
                          } else {
                            value.add(
                              Item(
                                  description: descriptionController.text,
                                  price: double.parse(priceController.text),
                                  quantity:
                                      double.parse(quantityController.text),
                                  purchased: false,
                                  unit: unit),
                            );
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
