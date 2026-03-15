import 'package:flutter/material.dart';
import 'package:myflutter/models/cart_item.dart';
import 'package:myflutter/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: ValueListenableBuilder(
        valueListenable: CartService.cartItems,
        builder: (context, cartItems, _) {
          if (cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return _cardList(context, item);
            },
          );
        },
      ),
    );
  }

  Widget _cardList(BuildContext context, CartItem item) {
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
}
