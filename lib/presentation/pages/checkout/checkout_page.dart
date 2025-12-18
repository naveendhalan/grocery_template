import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout/checkout_controller.dart';
import '../../widgets/checkout/checkout_address_card.dart';
import '../../widgets/checkout/payment_option_card.dart';
import '../../widgets/checkout/order_summary_card.dart';
import '../../widgets/checkout/confirm_order_button.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CheckoutAddressCard(),
              const SizedBox(height: 16),
              const PaymentOptionCard(),
              const SizedBox(height: 16),
              const OrderSummaryCard(),
              const SizedBox(height: 24),
              const ConfirmOrderButton(),
            ],
          ),
        ),
      ),
    );
  }
}
