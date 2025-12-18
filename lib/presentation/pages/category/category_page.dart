import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/category/category_controller.dart';
import '../../widgets/category/category_grid.dart';
import '../../widgets/category/category_header.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }

          final categories = controller.categories;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CategoryHeader(),
                const SizedBox(height: 12),
                CategoryGrid(categories: categories),
              ],
            ),
          );
        }),
      ),
    );
  }
}
