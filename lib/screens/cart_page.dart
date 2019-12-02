import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.display4),        
      ),
      body: Container(        
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemNameStyle = Theme.of(context).textTheme.title;

    return Consumer<CartModel>(
      builder: (context, cart, child) => ListView.builder(
        itemCount: cart.cartProducts.length,
        itemBuilder: (context, index) => ListTile(          
          title: Text(
            cart.cartProducts[index].name,
            style: itemNameStyle,
          ),
          subtitle: Text('${cart.cartProducts[index].price.toString()}\$'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => cart.removeProduct(cart.cartProducts[index].id),
          ),
          onTap: () => Navigator.popAndPushNamed(context, '/product', arguments: cart.cartProducts[index]),
        ),
      ),    
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.display4.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.allCost}', style: hugeStyle)),
            SizedBox(width: 24),
            FlatButton(              
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              color: Colors.yellow,
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
