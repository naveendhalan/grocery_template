import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/checkout/checkout_controller.dart';

class PaymentOptionCard extends StatelessWidget {
  const PaymentOptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<CheckoutController>();

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 18, spreadRadius: 2, offset: const Offset(0, 8))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Payment Method',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(
            () => Column(
              children: [
                _PaymentOption(icon: Icons.money, title: 'Cash on Delivery', isSelected: controller.selectedPaymentMethod.value == PaymentMethod.cash, onTap: () => controller.selectPaymentMethod(PaymentMethod.cash)),
                const SizedBox(height: 12),
                _PaymentOption(
                  icon: Icons.credit_card,
                  title: 'Credit/Debit Card',
                  isSelected: controller.selectedPaymentMethod.value == PaymentMethod.card,
                  onTap: () => controller.selectPaymentMethod(PaymentMethod.card),
                ),
                const SizedBox(height: 12),
                _PaymentOption(icon: Icons.account_balance_wallet, title: 'UPI', isSelected: controller.selectedPaymentMethod.value == PaymentMethod.upi, onTap: () => controller.selectPaymentMethod(PaymentMethod.upi)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({required this.icon, required this.title, required this.isSelected, required this.onTap});

  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline.withOpacity(0.2), width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface.withOpacity(0.7)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface),
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
