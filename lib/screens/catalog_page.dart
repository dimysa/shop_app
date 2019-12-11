import 'package:flutter/material.dart';
import 'package:myapp/screens/product_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/cart.dart';
import 'package:myapp/models/catalog.dart';
import 'package:myapp/models/product.dart';

class CatalogPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldDrawerKey;

  CatalogPage(this.scaffoldDrawerKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => scaffoldDrawerKey.currentState.openDrawer(),
            ),
            title: Text('Catalog', style: Theme.of(context).textTheme.display4),
            floating: true,
          ),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index),
                childCount: 100),
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var catalog = Provider.of<CatalogModel>(context);
    var item = catalog.getOrCreateProduct(index);
    var textTheme = Theme.of(context).textTheme.title;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: LimitedBox(
          maxHeight: 48,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: item.color,
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.name, style: textTheme),
                      Text('${item.price.toString()}\$'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 24),
              _AddButton(item: item),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductPage(),
          settings: RouteSettings(arguments: item),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Product item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return FlatButton(
      onPressed:
          cart.cartProducts.contains(item) ? null : () => cart.addProduct(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.cartProducts.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    );
  }
}
