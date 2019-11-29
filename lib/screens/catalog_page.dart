import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/cart.dart';
import 'package:myapp/models/catalog.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    if(cartModel.cartProducts.length > 0) {
      return SliverAppBar(
        title: Text('Catalog', style: Theme.of(context).textTheme.display4),
        floating: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      );
    }
    return SliverAppBar(
        title: Text('Catalog', style: Theme.of(context).textTheme.display4),
        floating: true,        
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

    return Padding(
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
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
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
      onPressed: cart.cartProducts.contains(item) ? null : () => cart.addProduct(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.cartProducts.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    );
  }
}