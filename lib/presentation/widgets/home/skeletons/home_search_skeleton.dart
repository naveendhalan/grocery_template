import 'package:flutter/material.dart';

import 'shimmer_widget.dart';

/// Skeleton loader for the home search bar
class HomeSearchSkeleton extends StatelessWidget {
  const HomeSearchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ShimmerWidget(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: theme.colorScheme.onSurface.withOpacity(0.3)),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
