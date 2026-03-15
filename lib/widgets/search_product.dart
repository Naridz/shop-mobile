import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  final Function(String) onChanged;
  const SearchProduct({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search . . .',
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon: Icon(
            Icons.tune,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          filled: true,
          fillColor: isDark ? Colors.grey[600] : Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(50),
          //   borderSide: BorderSide(
          //     color: isDark ? Colors.grey[300]! : Colors.grey[200]!,
          //     width: 1
          //   ),
          // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
