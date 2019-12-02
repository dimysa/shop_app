import 'package:flutter/material.dart';
import 'package:myapp/models/cart.dart';
import 'package:myapp/models/product.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.display4,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(child: _ProductImages(product)),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(product.name,
                            style: const TextStyle(fontSize: 28)),
                        Text(
                          '${product.price}\$',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(product.decsription.toString())),
                  _ProductRate(product),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: <Widget>[
                          Expanded(flex: 10, child: _AddToCartButton(product)),
                          Spacer(flex: 1),
                          Expanded(flex: 10, child: _AddReviewButton()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImages extends StatelessWidget {
  final Product product;

  _ProductImages(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        Image.network('https://picsum.photos/400', fit: BoxFit.cover),
        Image.network('https://picsum.photos/500', fit: BoxFit.cover),
        Image.network('https://picsum.photos/600', fit: BoxFit.cover),
      ],
    );
  }
}

class _ProductRate extends StatelessWidget {
  final Product product;

  _ProductRate(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _getIconFromRate(product.rate, 1),
        _getIconFromRate(product.rate, 2),
        _getIconFromRate(product.rate, 3),
        _getIconFromRate(product.rate, 4),
        _getIconFromRate(product.rate, 5),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            '0 REVIEWS',
            style: const TextStyle(color: Colors.grey, fontSize: 17),
          ),
        ),
      ],
    );
  }

  Icon _getIconFromRate(double rate, int position){
    return Icon(product.rate < position - 0.5 ? (Icons.star_border) : product.rate < position ? Icons.star_half : Icons.star);
  }
}

class _AddToCartButton extends StatelessWidget {
  final Product product;

  _AddToCartButton(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final isProductInCart = cart.cartProducts.contains(product);
    return SizedBox(
      child: RaisedButton(
        child: !isProductInCart
            ? Text('Add to cart', style: const TextStyle(fontSize: 20))
            : Text('Go to cart', style: const TextStyle(fontSize: 20)),
        color: Colors.yellow,
        textColor: Colors.black,
        onPressed: () => isProductInCart
            ? Navigator.popAndPushNamed(context, '/cart')
            : cart.addProduct(product),
      ),
      height: 50,
    );
  }
}

class _AddReviewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: RaisedButton(
        child: Text('Add review', style: const TextStyle(fontSize: 20)),
        color: Colors.grey.shade300,
        textColor: Colors.black,
        onPressed: () => Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Add Review'))),
      ),
      height: 50,
    );
  }
}
