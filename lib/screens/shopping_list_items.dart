import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/app_localizations.dart';
import 'package:shopping_list/components/base/screen.dart';
import 'package:shopping_list/components/formatter.dart';
import 'package:shopping_list/constants/routes.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/provider/items.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sprintf/sprintf.dart' as StringFormatter;

class ShoppingListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (context, itemsProvider, child) => ScreenBase(
        headerTitle:
            AppLocalizations.of(context)!.translate('ShoppingListItemsHeader'),
        drawer: true,
        body: ListView.builder(
          itemCount: itemsProvider.items.length,
          itemBuilder: (context, index) {
            Item item = itemsProvider.items[index];

            var actions = [
              IconSlideAction(
                caption: (item.purchased
                    ? AppLocalizations.of(context)!.translate('Undo')
                    : AppLocalizations.of(context)!.translate('Buy')),
                color: item.purchased ? Colors.yellow : Colors.green,
                icon: item.purchased
                    ? Icons.remove_shopping_cart_rounded
                    : Icons.add_shopping_cart_rounded,
                onTap: () =>
                    itemsProvider.changePurchase(item, !item.purchased),
              ),
              IconSlideAction(
                caption: AppLocalizations.of(context)!.translate('Edit'),
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
                caption: AppLocalizations.of(context)!.translate('Remove'),
                color: Colors.red,
                icon: Icons.edit,
                onTap: () => itemsProvider.remove(item),
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
                    _getSubtitle(context, item),
                    style: _getLineThrough(item),
                  ),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.itemsRoute,
                  arguments: index,
                ),
                onLongPress: () =>
                    itemsProvider.changePurchase(item, !item.purchased),
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
              StringFormatter.sprintf(
                  AppLocalizations.of(context)!.translate('TotalString'), [
                Formatter.formatCurrency(
                    itemsProvider.total, AppLocalizations.of(context)!.locale)
              ]),
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

String _getSubtitle(BuildContext context, Item item) {
  return StringFormatter.sprintf(
    AppLocalizations.of(context)!.translate('SubtitleString'),
    [
      item.unit.formatQuantity(item.quantity),
      item.unit.abbreviation,
      Formatter.formatCurrency(
          item.price, AppLocalizations.of(context)!.locale),
      Formatter.formatCurrency(
          item.quantity * item.price, AppLocalizations.of(context)!.locale)
    ],
  );
}
