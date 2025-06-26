// utils/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/products.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get shippingCost => subtotal >= 50 ? 0.0 : 5.0;
  double get tax => subtotal * 0.1; // 10% tax
  double get total => subtotal + shippingCost + tax;

  void addItem(Product product, [int quantity = 1]) {
  final index = _items.indexWhere((item) => item.product.id == product.id);
  if (index >= 0) {
    _items[index].quantity += quantity;
  } else {
    _items.add(CartItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      product: product,
      quantity: quantity,
    ));
  }
  notifyListeners();
}

  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity > 0) {
        _items[index].quantity = quantity;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
