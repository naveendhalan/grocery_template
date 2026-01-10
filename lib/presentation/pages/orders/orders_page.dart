import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/orders/orders_controller.dart';
import '../../widgets/orders/order_card.dart';

class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.value.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        if (controller.orders.isEmpty) {
          return Center(child: Text('No orders yet', style: theme.textTheme.titleMedium));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.orders.length,
          itemBuilder: (context, i) {
            return OrderCard(order: controller.orders[i]);
          },
        );
      }),
    );
  }
}
