import 'package:flutter/material.dart';
import 'package:myapp/screens/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/cart.dart';
import 'package:myapp/models/catalog.dart';
import 'package:myapp/screens/catalog_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        },
      ),
    );
  }
}
