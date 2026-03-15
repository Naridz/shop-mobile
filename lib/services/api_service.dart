import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<String>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/categories'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.cast<String>();
    } else {
      throw Exception("Failed to load categories");
    }
  }
}
