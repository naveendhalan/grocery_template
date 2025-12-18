import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_detail_controller.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../controllers/wishlist/wishlist_binding.dart';

class ProductDetailHeader extends GetView<ProductDetailController> {
  const ProductDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ensure wishlist controller is available
    if (!Get.isRegistered<WishlistController>()) {
      WishlistBinding().dependencies();
    }

    return Obx(() {
      final wishlistController = Get.find<WishlistController>();
      final product = controller.currentProduct;
      final isFavorite = wishlistController.isInWishlist(product);

      return Row(
        children: <Widget>[
          Expanded(
            child: Text(
              controller.name.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            onPressed: () => wishlistController.toggleWishlist(product),
          ),
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
        ],
      );
    });
  }
}
