import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../config/routes/app_routes.dart';
import '../../controllers/checkout/checkout_controller.dart' show PaymentMethod;

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final arguments = Get.arguments as Map<String, dynamic>?;
    final orderId = arguments?['orderId'] as String? ?? '';
    final address = arguments?['address'] as AddressEntity?;
    final paymentMethod = arguments?['paymentMethod'] as PaymentMethod?;
    final total = arguments?['total'] as double? ?? 0.0;

    String getPaymentMethodName(PaymentMethod? method) {
      switch (method) {
        case PaymentMethod.cash:
          return 'Cash on Delivery';
        case PaymentMethod.card:
          return 'Credit/Debit Card';
        case PaymentMethod.upi:
          return 'UPI';
        default:
          return 'Cash on Delivery';
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 60,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Order Placed Successfully!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your order has been confirmed',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InfoRow(label: 'Order ID', value: orderId, theme: theme),
                    const Divider(height: 24),
                    if (address != null) ...[
                      _InfoRow(
                        label: 'Delivery Address',
                        value: address.fullAddress,
                        theme: theme,
                        isMultiline: true,
                      ),
                      const Divider(height: 24),
                    ],
                    _InfoRow(
                      label: 'Payment Method',
                      value: getPaymentMethodName(paymentMethod),
                      theme: theme,
                    ),
                    const Divider(height: 24),
                    _InfoRow(
                      label: 'Total Amount',
                      value: '₹${total.toStringAsFixed(2)}',
                      theme: theme,
                      isBold: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.home),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    shadowColor: Colors.black12.withOpacity(0.08),
                  ),
                  child: Text(
                    'Continue Shopping',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.theme,
    this.isMultiline = false,
    this.isBold = false,
  });

  final String label;
  final String value;
  final ThemeData theme;
  final bool isMultiline;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: theme.colorScheme.onSurface,
            height: isMultiline ? 1.5 : 1.0,
          ),
        ),
      ],
    );
  }
}
