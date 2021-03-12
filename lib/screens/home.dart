import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/base/screen.dart';
import 'package:shopping_list/constants/routes.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/provider/items.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currency =
        NumberFormat.currency(locale: 'pt_BR', decimalDigits: 2, symbol: '');

    TextStyle? getLineThrough(Item value) {
      if (value.purchased) {
        return TextStyle(
          decoration: TextDecoration.lineThrough,
        );
      }
      return null;
    }

    return Consumer<ItemsProvider>(
      builder: (context, value, child) => ScreenBase(
        headerTitle: 'Home Page',
        drawer: true,
        body: ListView.builder(
          itemCount: value.items.length,
          itemBuilder: (context, index) {
            Item item = value.items[index];
            var places = NumberFormat.currency(
                decimalDigits: item.unit.decimalPlaces, symbol: '');

            return ListTile(
              title: Text(
                item.description,
                style: getLineThrough(item),
              ),
              subtitle: Text(
                '${places.format(item.quantity)} ${item.unit.description} x R\$${currency.format(item.price)} = R\$${currency.format(item.quantity * item.price)}',
                style: getLineThrough(item),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.itemsRoute,
                arguments: index,
              ),
              onLongPress: () => value.changePurchase(item, !item.purchased),
              trailing: Text(item.purchased ? 'Purchased!' : ''),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.itemsRoute,
          ),
          child: Icon(Icons.add),
        ),
        bottomBar: BottomAppBar(
          elevation: 16.0,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Text(
              'Total: R\$ ${currency.format(value.total)}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
