import 'package:get/get.dart';

import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/product/product_entity.dart';

class CartController extends GetxController {
  final RxList<CartItemEntity> cartItems = <CartItemEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDemoData();
  }

  void _loadDemoData() {
    // Demo cart items
    cartItems.assignAll([
      CartItemEntity(
        id: '1',
        product: const ProductEntity(id: '1', name: 'Fresh Tomatoes', image: 'assets/images/product1.png', price: 2.99, mrp: 3.99, description: 'Fresh red tomatoes', inStock: true),
        quantity: 2,
      ),
      CartItemEntity(
        id: '2',
        product: const ProductEntity(id: '2', name: 'Organic Carrots', image: 'assets/images/product2.png', price: 1.99, mrp: null, description: 'Fresh organic carrots', inStock: true),
        quantity: 1,
      ),
    ]);
  }

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 5.0;

  double get total => subtotal + deliveryFee;

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void addItem(ProductEntity product) {
    final existingItemIndex = cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingItemIndex != -1) {
      final existingItem = cartItems[existingItemIndex];
      cartItems[existingItemIndex] = CartItemEntity(id: existingItem.id, product: existingItem.product, quantity: existingItem.quantity + 1);
    } else {
      cartItems.add(CartItemEntity(id: DateTime.now().millisecondsSinceEpoch.toString(), product: product, quantity: 1));
    }
  }

  void removeItem(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
  }

  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(itemId);
      return;
    }

    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      final item = cartItems[index];
      cartItems[index] = CartItemEntity(id: item.id, product: item.product, quantity: newQuantity);
    }
  }

  void incrementQuantity(String itemId) {
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      final item = cartItems[index];
      updateQuantity(itemId, item.quantity + 1);
    }
  }

  void decrementQuantity(String itemId) {
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      final item = cartItems[index];
      updateQuantity(itemId, item.quantity - 1);
    }
  }

  void clearCart() {
    cartItems.clear();
  }
}
