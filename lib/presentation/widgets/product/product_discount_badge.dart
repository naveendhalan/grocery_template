import 'package:flutter/material.dart';

class ProductDiscountBadge extends StatelessWidget {
  const ProductDiscountBadge({super.key, required this.discount});

  final int discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: const Color(0xFFE53935), borderRadius: BorderRadius.circular(20)),
      child: Text(
        '-$discount%',
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}
