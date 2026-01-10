import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_template/presentation/controllers/cart/cart_binding.dart';
import 'package:grocery_template/presentation/controllers/cart/cart_controller.dart';

import '../../domain/entities/product/product_entity.dart';

/// Controller for the Product Detail page.
///
/// Holds only UI-facing state and local demo data – no external API calls.
class ProductDetailController extends GetxController {
  // Core product info
  final RxString productId = ''.obs;
  final RxString name = ''.obs;
  final RxDouble price = 0.0.obs;
  final RxDouble? mrp = 0.0.obs;
  final RxDouble discount = 0.0.obs;
  final RxBool inStock = true.obs;
  final RxInt quantity = 1.obs;

  // Extended content
  final RxString description = ''.obs;
  final RxString keyFeatures = ''.obs;
  final RxString disclaimer = ''.obs;

  // Media & relations
  final RxList<String> productImages = <String>[].obs;
  final RxList<ProductEntity> relatedProducts = <ProductEntity>[].obs;

  // Favorite state
  final RxBool isFavorite = false.obs;

  // All products for lookup
  final Map<String, ProductEntity> _productsMap = {};

  @override
  void onInit() {
    super.onInit();
    _initializeProducts();
    _loadProductFromArguments();
  }

  void _initializeProducts() {
    final allProducts = [
      const ProductEntity(id: 'p1', name: 'Fresh Tomatoes 1kg', image: 'assets/images/tomato.png', price: 45, mrp: 60, description: 'Juicy red tomatoes perfect for salads and curries.', inStock: true),
      const ProductEntity(id: 'p2', name: 'Premium Potatoes 2kg', image: 'assets/images/potato.png', price: 70, mrp: 90, description: 'Clean, starchy potatoes ideal for fries and mash.', inStock: true),
      const ProductEntity(id: 'p3', name: 'Organic Carrots 500g', image: 'assets/images/carrot.png', price: 35, mrp: 45, description: 'Crunchy carrots great for snacking and juicing.', inStock: true),
      const ProductEntity(id: 'p4', name: 'Green Spinach Bunch', image: 'assets/images/spinach.png', price: 30, mrp: 40, description: 'Leafy spinach rich in iron and vitamins.', inStock: true),
      const ProductEntity(id: 'p5', name: 'Mixed Bell Peppers 500g', image: 'assets/images/pepper.png', price: 80, mrp: 100, description: 'Colourful peppers perfect for stir-fries and salads.', inStock: true),
    ];

    for (var product in allProducts) {
      _productsMap[product.id] = product;
    }
  }

  void _loadProductFromArguments() {
    final productIdArg = Get.arguments as String?;
    if (productIdArg != null && _productsMap.containsKey(productIdArg)) {
      _loadProduct(_productsMap[productIdArg]!);
    } else {
      // Default to first product if no ID provided
      _loadProduct(_productsMap.values.first);
    }
  }

  void _loadProduct(ProductEntity product) {
    productId.value = product.id;
    name.value = product.name;
    price.value = product.price;
    mrp?.value = product.mrp ?? 0.0;
    discount.value = product.mrp != null && product.mrp! > product.price ? ((product.mrp! - product.price) / product.mrp!) * 100 : 0.0;
    inStock.value = product.inStock;
    quantity.value = 1;
    description.value = product.description ?? '';

    // Set key features and disclaimer
    keyFeatures.value = '• Rich in antioxidants\n• Naturally ripened\n• Carefully sorted for quality';
    disclaimer.value = 'Actual product packaging and materials may contain more and different information than what is shown here.';

    // Set product images
    productImages.assignAll([product.image, 'assets/images/carrot.png', 'assets/images/pepper.png']);

    // Set related products (exclude current product)
    relatedProducts.assignAll(_productsMap.values.where((p) => p.id != product.id).take(3).toList());
  }

  ProductEntity get currentProduct {
    return ProductEntity(id: productId.value, name: name.value, image: productImages.isNotEmpty ? productImages.first : '', price: price.value, mrp: mrp?.value, description: description.value, inStock: inStock.value);
  }

  void addToCart() {
    if (!inStock.value) return;

    // Ensure cart controller is available
    if (!Get.isRegistered<CartController>()) {
      CartBinding().dependencies();
    }

    final cartController = Get.find<CartController>();
    final product = currentProduct;

    // Add product to cart with selected quantity
    for (int i = 0; i < quantity.value; i++) {
      cartController.addItem(product);
    }

    // Show success message
    Get.snackbar(
      'Added to Cart',
      '${quantity.value} x ${product.name} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primaryContainer,
      colorText: Get.theme.colorScheme.onPrimaryContainer,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );

    // Reset quantity
    quantity.value = 1;
  }

  void incrementQuantity() {
    if (!inStock.value) return;
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value <= 1) return;
    quantity.value--;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}
