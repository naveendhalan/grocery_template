import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_detail_controller.dart';
import 'product_price_row.dart';

class ProductDetailNamePrice extends GetView<ProductDetailController> {
  const ProductDetailNamePrice({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () {
        final String name = controller.name.value;
        final double price = controller.price.value;
        final double mrp = controller.mrp!.value;
        final double discount = controller.discount.value;

        final double? effectiveMrp = discount > 0 && mrp > 0 ? mrp : null;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12.withOpacity(0.08),
                blurRadius: 18,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              // Placeholder unit / variant label
              Text(
                '1 unit',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              ProductPriceRow(
                price: price,
                mrp: effectiveMrp,
              ),
            ],
          ),
        );
      },
    );
  }
}

