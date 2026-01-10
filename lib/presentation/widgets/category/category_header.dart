import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text('Shop by Category', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
    );
  }
}
