import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_routes.dart';
import '../../../domain/entities/order_entity.dart';
import '../../controllers/orders/orders_controller.dart';
import '../../widgets/orders/order_item_tile.dart';

class OrderDetailPage extends GetView<OrdersController> {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orderId = Get.arguments as String;
    return FutureBuilder<OrderEntity?>(
      future: controller.getOrderDetail(orderId),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final order = snap.data!;
        return Scaffold(
          appBar: AppBar(title: Text('Order ${order.id}')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${order.status}', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Placed at: ${order.placedAt}', style: theme.textTheme.bodySmall),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: [
                      ...order.items.map((it) => OrderItemTile(item: it)).toList(),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Delivery Address', style: theme.textTheme.bodyMedium),
                            const SizedBox(height: 6),
                            Text(order.address, style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Subtotal: ₹${order.subTotal.toStringAsFixed(2)}'),
                      Text('Delivery: ₹${order.deliveryFee.toStringAsFixed(2)}'),
                      Text('Total: ₹${order.total.toStringAsFixed(2)}', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 16),
                      if (order.status.toLowerCase() == 'delivered' && !order.reviewed)
                        ElevatedButton(
                          onPressed: () async {
                            // open review flow and pass product from first item (add support for multiple)
                            final firstItem = order.items.isNotEmpty ? order.items.first : null;
                            if (firstItem != null) {
                              final result = await Get.toNamed(AppRoutes.reviewFlow, arguments: {'productId': firstItem.productId, 'productName': firstItem.name, 'productImage': firstItem.image, 'orderId': order.id});
                              if (result != null) {
                                // mark order reviewed in repository / controller
                                controller.setOrderReviewed(order.id);
                              }
                            }
                          },
                          child: const Text('Write a Review'),
                        )
                      else if (order.reviewed)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(8)),
                          child: const Text('You reviewed this order'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
