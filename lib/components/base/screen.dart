import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                  Text(AppLocalizations.of(context)!.appName)
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Routes.menuRoutes(context).length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(Routes.menuRoutes(context)[index].title),
                  onTap: () => Navigator.pushReplacementNamed(
                      context, Routes.menuRoutes(context)[index].route),
                );
              },
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.about,
              ),
              onTap: () => showAboutDialog(
                context: context,
                applicationIcon: Icon(Icons.info_outline),
                applicationName: AppLocalizations.of(context)!.appName,
                applicationVersion: AppLocalizations.of(context)!.appVersion,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.appAbout,
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
