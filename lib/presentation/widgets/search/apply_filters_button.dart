import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

import '../../controllers/search/search_controller.dart';

class ApplyFiltersButton extends StatelessWidget {
  const ApplyFiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<SearchController>();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.applyFilters(controller.selectedFilters);
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          shadowColor: Colors.black12..withValues(alpha: 0.08),
        ),
        child: Text(
          'Apply Filters',
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
