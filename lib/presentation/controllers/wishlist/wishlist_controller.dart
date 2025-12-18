import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/product/product_entity.dart';

class WishlistController extends GetxController {
  final RxList<ProductEntity> wishlistItems = <ProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDemoData();
  }

  void _loadDemoData() {
    // Demo wishlist items
    wishlistItems.assignAll([
      const ProductEntity(
        id: 'p1',
        name: 'Fresh Tomatoes 1kg',
        image: 'assets/images/tomato.png',
        price: 45,
        mrp: 60,
        description: 'Juicy red tomatoes perfect for salads and curries.',
        inStock: true,
      ),
    ]);
  }

  int get itemCount => wishlistItems.length;

  bool isInWishlist(ProductEntity product) {
    return wishlistItems.any((item) => item.id == product.id);
  }

  void addToWishlist(ProductEntity product) {
    if (!isInWishlist(product)) {
      wishlistItems.add(product);
      Get.snackbar(
        'Added to Wishlist',
        '${product.name} added to wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void removeFromWishlist(ProductEntity product) {
    wishlistItems.removeWhere((item) => item.id == product.id);
    Get.snackbar(
      'Removed from Wishlist',
      '${product.name} removed from wishlist',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primaryContainer,
      colorText: Get.theme.colorScheme.onPrimaryContainer,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void toggleWishlist(ProductEntity product) {
    if (isInWishlist(product)) {
      removeFromWishlist(product);
    } else {
      addToWishlist(product);
    }
  }
}
