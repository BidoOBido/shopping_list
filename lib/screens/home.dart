import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/base/screen.dart';
import 'package:shopping_list/constants/routes.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/provider/items.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

            return Slidable(
              actionPane: SlidableScrollActionPane(),
              actionExtentRatio: .5 * (1 / 3),
              child: ListTile(
                title: Center(
                  child: Text(
                    item.description,
                    style: getLineThrough(item),
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    '${places.format(item.quantity)} ${item.unit.description} x R\$${currency.format(item.price)} = R\$${currency.format(item.quantity * item.price)}',
                    style: getLineThrough(item),
                  ),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.itemsRoute,
                  arguments: index,
                ),
                onLongPress: () => value.changePurchase(item, !item.purchased),
              ),
              actions: [
                IconSlideAction(
                  caption: (item.purchased ? 'Undo' : 'Purchase'),
                  color: item.purchased ? Colors.yellow : Colors.green,
                  icon: item.purchased
                      ? Icons.remove_shopping_cart_rounded
                      : Icons.add_shopping_cart_rounded,
                  onTap: () => value.changePurchase(item, !item.purchased),
                ),
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.itemsRoute,
                    arguments: index,
                  ),
                ),
              ],
              secondaryActions: [
                IconSlideAction(
                  caption: 'Remove',
                  color: Colors.red,
                  icon: Icons.edit,
                  onTap: () => value.remove(item),
                ),
              ],
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
