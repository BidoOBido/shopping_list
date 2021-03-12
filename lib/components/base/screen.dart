import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopping_list/constants/routes.dart';

class ScreenBase extends StatelessWidget {
  final String headerTitle;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomBar;
  final bool? drawer;

  const ScreenBase({
    Key? key,
    required this.headerTitle,
    required this.body,
    this.floatingActionButton,
    this.bottomBar,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headerTitle),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: _getDrawer(context),
    );
  }

  Drawer? _getDrawer(BuildContext context) {
    if (drawer ?? false) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_rounded),
                  Text('Shopping List')
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Routes.menuRoutes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(Routes.menuRoutes[index].title),
                  onTap: () => Navigator.pushReplacementNamed(
                      context, Routes.menuRoutes[index].route),
                );
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () => showAboutDialog(
                context: context,
                applicationIcon: Icon(Icons.info_outline),
                applicationName: 'AppName',
                applicationVersion: 'AppVersion',
                children: <Widget>[
                  Text(
                    'AppAbout',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return null;
  }
}