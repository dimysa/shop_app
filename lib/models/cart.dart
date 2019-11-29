import 'package:flutter/foundation.dart';
import 'package:myapp/models/catalog.dart';

class CartModel extends ChangeNotifier {
  final cartProducts = List<Product>();

  int get allCost =>
      cartProducts.fold(0, (total, current) => total + current.price);

  void addProduct(Product product) {
    cartProducts.add(product);
    notifyListeners();
  }

  void removeProduct(int id) {
    cartProducts.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
