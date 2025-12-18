import 'package:flutter/material.dart';

class ProductPriceRow extends StatelessWidget {
  const ProductPriceRow({
    super.key,
    required this.price,
    this.mrp,
  });

  final double price;
  final double? mrp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: <Widget>[
        Text(
          '₹${price.toStringAsFixed(0)}',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(width: 6),
        if (mrp != null)
          Text(
            '₹${mrp!.toStringAsFixed(0)}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }
}



