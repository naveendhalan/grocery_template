import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../../config/routes/app_routes.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../controllers/wishlist/wishlist_binding.dart';
import 'product_discount_badge.dart';
import 'product_image.dart';
import 'product_price_row.dart';
import 'product_veg_badge.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double? mrp = product.mrp;
    final double price = product.price;

    // Ensure wishlist controller is available
    if (!Get.isRegistered<WishlistController>()) {
      WishlistBinding().dependencies();
    }

    int discount = 0;
    if (mrp != null && mrp > 0 && mrp > price) {
      discount = (((mrp - price) / mrp) * 100).round();
    }

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.productDetail, arguments: product.id);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              blurRadius: 18,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProductImage(imageUrl: product.image),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ProductPriceRow(price: price, mrp: mrp),
                ],
              ),
            ),
            const Positioned(top: 8, left: 8, child: ProductVegBadge()),
            Positioned(
              top: 8,
              right: 8,
              child: Obx(() {
                final wishlistController = Get.find<WishlistController>();
                final isFavorite = wishlistController.isInWishlist(product);
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? theme.colorScheme.error
                        : theme.colorScheme.onSurface.withOpacity(0.6),
                    size: 20,
                  ),
                  onPressed: () {
                    wishlistController.toggleWishlist(product);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                );
              }),
            ),
            if (discount > 0)
              Positioned(
                top: 40,
                right: 8,
                child: ProductDiscountBadge(discount: discount),
              ),
          ],
        ),
      ),
    );
  }
}
