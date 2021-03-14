import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/base/screen.dart';
import 'package:shopping_list/components/formater.dart';
import 'package:shopping_list/constants/routes.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/provider/items.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (context, value, child) => ScreenBase(
        headerTitle: 'Home Page',
        drawer: true,
        body: ListView.builder(
          itemCount: value.items.length,
          itemBuilder: (context, index) {
            Item item = value.items[index];

            var actions = [
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
            ];

            var secondaryActions = [
              IconSlideAction(
                caption: 'Remove',
                color: Colors.red,
                icon: Icons.edit,
                onTap: () => value.remove(item),
              ),
            ];

            return Slidable(
              actionPane: SlidableScrollActionPane(),
              actionExtentRatio:
                  .5 * (1 / (actions.length + secondaryActions.length)),
              child: ListTile(
                title: Center(
                  child: Text(
                    item.description,
                    style: _getLineThrough(item),
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    _getSubtitle(item),
                    style: _getLineThrough(item),
                  ),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.itemsRoute,
                  arguments: index,
                ),
                onLongPress: () => value.changePurchase(item, !item.purchased),
              ),
              actions: actions,
              secondaryActions: secondaryActions,
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
              'Total: R\$ ${Formater.formatCurrency(value.total)}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

TextStyle? _getLineThrough(Item value) {
  if (value.purchased) {
    return TextStyle(
      decoration: TextDecoration.lineThrough,
    );
  }
  return null;
}

String _getSubtitle(Item item) {
  return "${item.unit.formatQuantity(item.quantity)} ${item.unit.abbreviation} x R\$${Formater.formatCurrency(item.price)} = R\$${Formater.formatCurrency(item.quantity * item.price)}";
}
