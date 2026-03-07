import 'package:flutter/material.dart';
import 'package:myflutter/main.dart';
import 'package:myflutter/widgets/category_filter.dart';
import 'package:myflutter/widgets/product_list.dart';
import 'package:myflutter/widgets/search_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.network(
                    'https://flutter.dev/assets/icon_flutter.4262c71228b7aa391e995fe5f1d57795.png',
                    height: 20,
                    width: 20,
                  ),

                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart_outlined),
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
            //search
            SearchProduct(),
            //categories
            CategoryFilter(),
            //product
            SizedBox(height: 50,),
            Expanded(child: ProductList()),
          ],
        ),
      ),
    );
  }
}
