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
    Unit unit = Unit(description: '', decimalPlaces: 0);

    return Consumer<ItemsProvider>(
      builder: (context, value, child) => ScreenBase(
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
                    // initialValue: '1',
                    keyboardType: TextInputType.numberWithOptions(signed: true),
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
                    // initialValue: '0',
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
                    validator: (value) =>
                        value == null ? 'Please select some unit' : null,
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        value.add(
                          Item(
                              description: descriptionController.text,
                              price: double.parse(priceController.text),
                              quantity: double.parse(quantityController.text),
                              purchased: false,
                              unit: unit),
                        );

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
      ),
    );
  }
}
