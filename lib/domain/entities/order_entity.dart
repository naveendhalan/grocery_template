class OrderItemEntity {
  final String id;
  final String productId;
  final String name;
  final String image;
  final int quantity;
  final double price;

  const OrderItemEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });
}

class OrderEntity {
  final String id;
  final String status; // e.g., Delivered, Shipped
  final DateTime placedAt;
  final DateTime? deliveredAt;
  final double subTotal;
  final double deliveryFee;
  final double total;
  final List<OrderItemEntity> items;
  final String address;
  final bool reviewed; // whether user already wrote review

  const OrderEntity({
    required this.id,
    required this.status,
    required this.placedAt,
    this.deliveredAt,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
    required this.items,
    required this.address,
    this.reviewed = false,
  });
}
