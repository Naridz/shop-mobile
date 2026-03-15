import 'package:flutter/material.dart';
import 'package:myflutter/main.dart';
import 'package:myflutter/screens/cart_screen.dart';
import 'package:myflutter/services/api_service.dart';
import 'package:myflutter/widgets/category_filter.dart';
import 'package:myflutter/widgets/product_list.dart';
import 'package:myflutter/widgets/search_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> futureCategories;
  String selectedCategory = "All";
  String searchText = "";

  @override
  void initState() {
    super.initState();
    futureCategories = ApiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            // header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.network(
                    'https://flutter.dev/assets/icon_flutter.4262c71228b7aa391e995fe5f1d57795.png',
                    height: 20,
                    width: 20,
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),

                  IconButton(
                    onPressed: () {
                      themeNotifier.value =
                          themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                    icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  ),
                ],
              ),
            ),

            // search
            SearchProduct(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            const SizedBox(height: 10),

            // categories from API
            FutureBuilder<List<String>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text("Failed to load categories");
                }

                final categories = ["All", ...snapshot.data!];

                return CategoryFilter(
                  categories: categories,
                  selectedCategory: selectedCategory,
                  onSelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            // product list
            Expanded(
              child: ProductList(
                category: selectedCategory,
                searchText: searchText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Image.network(
//                     'https://flutter.dev/assets/icon_flutter.4262c71228b7aa391e995fe5f1d57795.png',
//                     height: 20,
//                     width: 20,
//                   ),

//                   Spacer(),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.shopping_cart_outlined),
//                   ),

//                   IconButton(
//                     onPressed: () {
//                       themeNotifier.value =
//                           themeNotifier.value == ThemeMode.light
//                           ? ThemeMode.dark
//                           : ThemeMode.light;
//                     },
//                     icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
//                   ),
//                 ],
//               ),
//             ),
//             //search
//             SearchProduct(),
//             //categories
//             CategoryFilter(),
//             //product
//             SizedBox(height: 50,),
//             Expanded(child: ProductList()),
//           ],
//         ),
//       ),
//     );
//   }
// }
