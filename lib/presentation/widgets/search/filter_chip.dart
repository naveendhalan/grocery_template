import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

import '../../../domain/entities/filter_entity.dart';
import '../../controllers/search/search_controller.dart';

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({super.key, required this.filter});

  final FilterEntity filter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<SearchController>();

    return Obx(() {
      final isSelected = controller.isFilterSelected(filter.id);

      return FilterChip(
        label: Text(filter.name),
        selected: isSelected,
        onSelected: (selected) {
          controller.toggleFilter(filter);
        },
        selectedColor: theme.colorScheme.primaryContainer,
        checkmarkColor: theme.colorScheme.onPrimaryContainer,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        side: BorderSide(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline
            ..withValues(alpha: 0.2),
          width: isSelected ? 2 : 1,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );
    });
  }
}
