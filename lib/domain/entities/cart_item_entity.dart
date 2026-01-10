import 'product/product_entity.dart';

class CartItemEntity {
  final String id;
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({required this.id, required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;
}
