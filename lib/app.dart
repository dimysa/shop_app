import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/i18n/localization.dart';
import 'package:myapp/models/address_info.dart';
import 'package:myapp/screens/delivery_info_page.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/cart.dart';
import 'package:myapp/models/catalog.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _setupFirebaseNotification();
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProvider<CartModel>(
          create: (context) => CartModel(),
        ),
        Provider(
          create: (context) => AddressInfoModel(),
        ),
        FutureProvider(
          create: (context) => AddressInfoModel().addresses,
        ),
      ],
      child: MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('ru'),
        ],
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
          '/': (context) => HomePage(),
          DeliveryInfoPage.routeName: (context) => DeliveryInfoPage(),
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
