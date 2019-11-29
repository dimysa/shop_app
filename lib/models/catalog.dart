import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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

@immutable
class Product {
  final int id;
  final String name;
  final Color color;
  final int price = Random().nextInt(100);  

  Product(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override  
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Product && id == other.id;
}
