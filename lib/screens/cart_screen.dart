import 'package:flutter/material.dart';
import 'package:myflutter/models/cart_item.dart';
import 'package:myflutter/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: CartService.cartItems,
              builder: (context, cartItems, _) {
                if (cartItems.isEmpty) {
                  return const Center(child: Text("Your cart is empty"));
                }

                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return _cartList(context, item);
                  },
                );
              },
            ),
          ),
          _cartTotal(context),
        ],
      ),
    );
  }

  Widget _cartList(BuildContext context, CartItem item) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              item.product.image,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.product.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          CartService.removeFromCart(item);
                        },
                        icon: Icon(
                          Icons.delete_outlined,
                          color: Colors.red[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "฿${(item.product.price * item.quantity).toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                CartService.decreaseQuantity(item);
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 20,
                                color: Colors.deepOrange,
                              ),
                            ),
                            Text(
                              item.quantity.toString(),
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                            IconButton(
                              onPressed: () {
                                CartService.increaseQuantity(item);
                              },
                              icon: Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartTotal(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CartService.cartItems,
      builder: (context, cartItems, _) {
        final total = cartItems.fold(
          0.0,
          (sum, item) => sum + item.product.price * item.quantity,
        );
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -0.5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                '฿${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
