import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onSelected;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(categories.length, (index) {
          final category = categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ChoiceChip(
                label: Text(
                  category,
                  style: TextStyle(
                    color: selectedCategory == category
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                selected: selectedCategory == category,
                onSelected: (_) => onSelected(category),
                selectedColor: colorScheme.primary,
                backgroundColor: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: selectedCategory == category ? 2 : 0,
                pressElevation: 1,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 1,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                side: BorderSide(
                  color: selectedCategory == category
                      ? Colors.transparent
                      : colorScheme.outline.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
