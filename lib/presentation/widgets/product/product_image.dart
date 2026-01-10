import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
          alignment: Alignment.center,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image_not_supported, color: theme.colorScheme.onSurface.withOpacity(0.4), size: 40);
            },
          ),
        ),
      ),
    );
  }
}
