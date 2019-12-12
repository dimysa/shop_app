import 'package:flutter/material.dart';
import 'package:myapp/i18n/localization.dart';
import 'package:myapp/screens/cart_page.dart';
import 'package:myapp/screens/catalog_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final scaffoldDrawerKey = GlobalKey<ScaffoldState>();
  final bottomTabNavigationBar = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldDrawerKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).catalog),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context).cart),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          WillPopScope(
            onWillPop: () async {
              return !await bottomTabNavigationBar.currentState.maybePop();
            },
            child: Navigator(
              key: bottomTabNavigationBar,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    switch (settings.name) {
                      case '/':
                        return CatalogPage(scaffoldDrawerKey);
                      default:
                        return CatalogPage(scaffoldDrawerKey);
                    }
                  },
                );
              },
            ),
          ),
          CartPage(scaffoldDrawerKey),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.yellow,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade600,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text(AppLocalizations.of(context).catalog),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text(AppLocalizations.of(context).cart),
          ),
        ],
      ),
    );
  }
}
