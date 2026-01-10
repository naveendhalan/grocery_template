import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart/cart_controller.dart';
import '../../widgets/cart/cart_item_card.dart';
import '../../widgets/cart/cart_total_card.dart';
import '../../widgets/cart/checkout_button.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Cart (${controller.totalItems})',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => controller.cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 80, color: theme.colorScheme.onSurface.withOpacity(0.3)),
                      const SizedBox(height: 16),
                      Text('Your cart is empty', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
                      const SizedBox(height: 8),
                      Text('Add items to your cart to continue', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CartItemCard(cartItem: controller.cartItems[index]),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 18, spreadRadius: 2, offset: const Offset(0, -8))],
                      ),
                      child: Column(children: [const CartTotalCard(), const SizedBox(height: 16), const CheckoutButton()]),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
