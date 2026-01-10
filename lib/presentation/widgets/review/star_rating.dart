import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int value; // current value 1..5
  final int maxStars;
  final ValueChanged<int> onChanged;
  final double size;

  const StarRating({super.key, required this.value, required this.onChanged, this.maxStars = 5, this.size = 32});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (i) {
        final idx = i + 1;
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tight(Size(size, size)),
          icon: Icon(idx <= value ? Icons.star : Icons.star_border, size: size, color: theme.colorScheme.primary),
          onPressed: () => onChanged(idx),
        );
      }),
    );
  }
}
