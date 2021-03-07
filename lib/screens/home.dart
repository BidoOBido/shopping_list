import 'package:flutter/material.dart';
import 'package:shopping_list/components/base/screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      headerTitle: 'Home Page',
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      bottomBar: BottomAppBar(
        elevation: 16.0,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Text(
            'Total:',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
