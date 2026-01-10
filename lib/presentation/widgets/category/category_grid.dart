import 'package:flutter/material.dart';

import '../../../domain/entities/category/category_entity.dart';
import 'category_card.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 14, childAspectRatio: 0.9),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
        return CategoryCard(
          category: category,
          onTap: () {
            // For template: print category name only.
            // ignore: avoid_print
            print('Category tapped: ${category.name}');
          },
        );
      },
    );
  }
}
