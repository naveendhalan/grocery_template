import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../controllers/search/search_controller.dart';
import '../../widgets/search/search_text_field.dart';
import '../../widgets/search/search_result_card.dart';
import '../../../config/routes/app_routes.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Search',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: theme.colorScheme.onSurface),
            onPressed: () => Get.toNamed(AppRoutes.filter),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: const SearchTextField(),
            ),
            Obx(
              () => controller.selectedFilters.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.selectedFilters.length,
                        itemBuilder: (context, index) {
                          final filter = controller.selectedFilters[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              label: Text(filter.name),
                              onDeleted: () {
                                controller.toggleFilter(filter);
                              },
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              labelStyle: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              deleteIcon: Icon(
                                Icons.close,
                                size: 18,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Obx(
                () => controller.searchResults.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: theme.colorScheme.onSurface..withValues(alpha:
                              0.3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No results found',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onSurface..withValues(alpha:
                                0.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try a different search term or clear filters',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface..withValues(alpha:
                                0.5,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          return SearchResultCard(
                            product: controller.searchResults[index],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
