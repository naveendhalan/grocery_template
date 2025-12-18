import 'package:flutter/material.dart';
import '../../../domain/entities/order_entity.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItemEntity item;
  const OrderItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: SizedBox(
        width: 56,
        child: Image.asset(item.image, fit: BoxFit.cover),
      ),
      title: Text(item.name, style: theme.textTheme.bodyMedium),
      subtitle: Text('Qty: ${item.quantity}', style: theme.textTheme.bodySmall),
      trailing: Text('₹${(item.price * item.quantity).toStringAsFixed(2)}', style: theme.textTheme.bodyMedium),
    );
  }
}
