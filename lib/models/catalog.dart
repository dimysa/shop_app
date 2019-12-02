import 'package:english_words/english_words.dart';
import 'package:myapp/models/product.dart';

class CatalogModel {
  final _products = List<Product>();

  Product getOrCreateProduct(int position){
    if(_products.length > position)
      return _products[position];

    final product = Product(position, WordPair.random().asPascalCase);
    _products.add(product);
    return product;
  }
}