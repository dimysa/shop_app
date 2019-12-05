import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/cart_page.dart';
import 'package:myapp/screens/product_page.dart';
import 'package:myapp/models/cart.dart';
import 'package:myapp/models/catalog.dart';
import 'package:myapp/screens/catalog_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _setupFirebaseNotification();
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProvider<CartModel>(
          create: (context) => CartModel(),
        )
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          textTheme: TextTheme(
            display4: TextStyle(
              fontFamily: 'Corben',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => CatalogPage(),
          '/cart': (context) => CartPage(),
          '/product': (context) => ProductPage(),
        },
      ),
    );
  }

  void _setupFirebaseNotification() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      final _homeScreenText = "Push Messaging token: $token";
      print(_homeScreenText);
    });
  }
}
