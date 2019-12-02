import 'dart:math';
import 'package:flutter/material.dart';

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
