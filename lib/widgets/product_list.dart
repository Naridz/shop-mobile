import 'package:flutter/material.dart';
import 'package:myflutter/models/product.dart';
import 'package:myflutter/screens/product_detail_screen.dart';
import 'package:myflutter/services/api_product.dart';
import 'package:myflutter/widgets/product_card.dart';

class ProductList extends StatefulWidget {
  final String category;
  final String searchText;
  const ProductList({
    super.key,
    required this.category,
    required this.searchText,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (context, snapshot) {
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // error
        if (snapshot.hasError) {
          return const Center(child: Text("Failed to load products"));
        }

        // data
        final products = snapshot.data!;
        List<Product> filteredProducts = products;

        // filter category
        if (widget.category != "All") {
          filteredProducts = filteredProducts
              .where((p) => p.category == widget.category)
              .toList();
        }

        // filter search
        if (widget.searchText.isNotEmpty) {
          filteredProducts = filteredProducts
              .where(
                (p) => p.title.toLowerCase().contains(
                  widget.searchText.toLowerCase(),
                ),
              )
              .toList();
        }
        if (filteredProducts.isEmpty) {
          return const Center(child: Text("No products found"));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: ProductCard(product: product),
            );
          },
        );
      },
    );
  }
}
// ---
// class ProductList extends StatelessWidget {
//   const ProductList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> products = [
//       {
//         "id": 1,
//         "title": "Fjallraven Backpack",
//         "price": 109.95,
//         "description":
//             "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in",
//         "category": "men's clothing",
//         "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
//         "rating": {"rate": 3.9, "count": 120},
//       },
//     ];
//     return GridView.builder(
//       padding: EdgeInsets.all(16),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.72,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//       ),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ProductDetailScreen(product:product)),
//           ),
//           child: ProductCard(product: product),
//         );
//       },
//     );
//   }
// }
