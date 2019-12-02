import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _SliverProductAppBar(product),
          _SliverProductInfo(product),
        ],
      ),
    );
  }
}

class _SliverProductAppBar extends StatelessWidget {
  final Product product;

  _SliverProductAppBar(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 400.0,
        flexibleSpace: PageView(
          children: <Widget>[
            Image.network('https://picsum.photos/400', fit: BoxFit.cover),
            Image.network('https://picsum.photos/500', fit: BoxFit.cover),
            Image.network('https://picsum.photos/600', fit: BoxFit.cover),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Add new entry',
            onPressed: () {/* ... */},
          ),
        ]);
  }
}

class _SliverProductInfo extends StatelessWidget {
  final Product product;

  _SliverProductInfo(this.product, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(product.name, style: const TextStyle(fontSize: 32)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${product.price}\$',
                style: Theme.of(context).textTheme.display4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '0 REVIEWS',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
