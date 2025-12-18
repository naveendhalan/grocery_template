import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_routes.dart';
import '../../../domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.orderDetail, arguments: order.id);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: order.items.isNotEmpty
                  ? Image.asset(order.items.first.image, fit: BoxFit.cover)
                  : const SizedBox(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ${order.id}', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(order.status, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 6),
                  Text('${order.items.length} items • ${order.total.toStringAsFixed(2)}',
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '${order.placedAt.day}/${order.placedAt.month}/${order.placedAt.year}',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withOpacity(0.4)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
