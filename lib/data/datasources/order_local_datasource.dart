import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/order_model.dart';

class OrderLocalDataSource {
  // returns demo orders; you can replace with file/network later
  Future<List<OrderModel>> getOrders() async {
    // Demo data in code (no asset dependency)
    await Future.delayed(const Duration(milliseconds: 200));
    final now = DateTime.now();
    return <OrderModel>[
      OrderModel(
        id: 'ORD1001',
        status: 'Delivered',
        placedAt: now.subtract(const Duration(days: 3)),
        deliveredAt: now.subtract(const Duration(days: 1)),
        subTotal: 450.0,
        deliveryFee: 20.0,
        total: 470.0,
        items: [
          const OrderItemModel(
            id: 'oi1',
            productId: 'p1',
            name: 'Fresh Tomatoes 1kg',
            image: 'assets/images/tomato.png',
            quantity: 2,
            price: 45.0,
          ),
          const OrderItemModel(
            id: 'oi2',
            productId: 'p2',
            name: 'Premium Potatoes 2kg',
            image: 'assets/images/potato.png',
            quantity: 1,
            price: 70.0,
          ),
        ],
        address: 'House 12, MG Road, City',
        reviewed: false,
      ),
      OrderModel(
        id: 'ORD1002',
        status: 'Shipped',
        placedAt: now.subtract(const Duration(days: 1)),
        deliveredAt: null,
        subTotal: 250.0,
        deliveryFee: 20.0,
        total: 270.0,
        items: [
          const OrderItemModel(
            id: 'oi3',
            productId: 'p3',
            name: 'Organic Carrots 500g',
            image: 'assets/images/carrot.png',
            quantity: 2,
            price: 35.0,
          ),
        ],
        address: 'Flat 3B, Lajpat Nagar',
        reviewed: false,
      ),
    ];
  }
}
