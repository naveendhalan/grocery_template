import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../controllers/search/search_controller.dart';
import '../../widgets/search/filter_chip.dart';
import '../../widgets/search/apply_filters_button.dart';
import '../../../domain/entities/filter_entity.dart';

class FilterPage extends GetView<SearchController> {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Filters',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.clearFilters,
            child: Text(
              'Clear All',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FilterSection(
                      title: 'Category',
                      filters: controller.availableFilters
                          .where((f) => f.type == FilterType.category)
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    _FilterSection(
                      title: 'Price Range',
                      filters: controller.availableFilters
                          .where((f) => f.type == FilterType.price)
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    _FilterSection(
                      title: 'Rating',
                      filters: controller.availableFilters
                          .where((f) => f.type == FilterType.rating)
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withValues(alpha: 0.08),
                    blurRadius: 18,
                    spreadRadius: 2,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: const ApplyFiltersButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.filters});

  final String title;
  final List<FilterEntity> filters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filters
              .map((filter) => FilterChipWidget(filter: filter))
              .toList(),
        ),
      ],
    );
  }
}
