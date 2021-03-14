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
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _quantityController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    Unit _unit = DefaultUnits.units.first;
    bool _purchased = false;

    final int selectedIndex =
        int.tryParse(ModalRoute.of(context)!.settings.arguments.toString()) ??
            -1;

    return Consumer<ItemsProvider>(
      builder: (context, itemsProvider, child) {
        if (selectedIndex >= 0) {
          Item item = itemsProvider.items[selectedIndex];
          _descriptionController.text = item.description;
          _quantityController.text = item.quantity.toString();
          _priceController.text = item.price.toString();
          _unit = item.unit;
          _purchased = item.purchased;
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
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => _descriptionValidator(value),
                    ),
                    TextFormField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      validator: (value) => _quantityValidator(value),
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      validator: (value) {
                        return _priceValidator(value);
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Unit',
                      ),
                      onChanged: (Unit? selected) =>
                          _unit = selected ?? DefaultUnits.units.first,
                      items: _buildUnitList(),
                      value: _unit,
                      validator: (value) => _unitValidator(value),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Item item = Item(
                            description: _descriptionController.text,
                            price: double.parse(_priceController.text),
                            quantity: double.parse(_quantityController.text),
                            purchased: _purchased,
                            unit: _unit,
                          );

                          if (selectedIndex >= 0) {
                            item.id = selectedIndex;

                            itemsProvider.update(
                              selectedIndex,
                              item,
                            );
                          } else {
                            itemsProvider.add(item);
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

  List<DropdownMenuItem<Unit>> _buildUnitList() {
    return DefaultUnits.units.map(
      (Unit unit) {
        return DropdownMenuItem(
          value: unit,
          child: Text(unit.description),
        );
      },
    ).toList();
  }

  String? _unitValidator(Object? value) =>
      value == null ? 'Please select some unit' : null;

  String? _priceValidator(String? value) {
    if (((value ?? '').isEmpty) || (double.parse(value ?? '0') < 0)) {
      return 'Quantity must be zero or grater';
    }
    return null;
  }

  String? _quantityValidator(String? value) {
    if (((value ?? '').isEmpty) || (double.parse(value ?? '0') < 1)) {
      return 'Quantity must be greater than zero';
    }
    return null;
  }

  String? _descriptionValidator(String? value) {
    if ((value ?? '').isEmpty) {
      return 'Please informe some description';
    }
    return null;
  }
}
