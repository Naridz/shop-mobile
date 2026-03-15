import 'package:myflutter/models/cart_item.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

class CartService {
  static final ValueNotifier<List<CartItem>> cartItems =
      ValueNotifier<List<CartItem>>([]);

  static void addToCart(Product product) {
    final items = cartItems.value;

    final index = items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      items[index].quantity++;
    } else {
      items.add(CartItem(product: product));
    }

    cartItems.value = [...items];
  }

  static void increaseQuantity(CartItem item) {
    item.quantity++;
    cartItems.value = [...cartItems.value];
  }

  static void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeFromCart(item);
    }

    cartItems.value = [...cartItems.value];
  }

  static void removeFromCart(CartItem item) {
    cartItems.value = cartItems.value
        .where((i) => i.product.id != item.product.id)
        .toList();
  }
}
