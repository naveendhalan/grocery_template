import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_routes.dart';
import '../../controllers/cart/cart_binding.dart';
import '../../controllers/cart/cart_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../widgets/product/product_grid.dart';
import '../../widgets/product/product_header.dart';
import '../../widgets/product/product_sort_filter_bar.dart';

/// Product listing page – Day 2 layout placeholder.
///
/// Wire this page into routing in the routing module.
class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ensure cart controller is available
    if (!Get.isRegistered<CartController>()) {
      CartBinding().dependencies();
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          Obx(() {
            final cartController = Get.find<CartController>();
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: theme.colorScheme.onSurface),
                  onPressed: () => Get.toNamed(AppRoutes.cart),
                ),
                if (cartController.totalItems > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${cartController.totalItems}',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onError, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final products = controller.filteredProductList;

          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[ProductHeader(), SizedBox(height: 12), ProductSortFilterBar()]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverToBoxAdapter(child: ProductGrid(products: products)),
              ),
            ],
          );
        }),
      ),
    );
  }
}
