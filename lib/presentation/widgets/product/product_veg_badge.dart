import 'package:flutter/material.dart';

class ProductVegBadge extends StatelessWidget {
  const ProductVegBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF2AAF6D)),
      alignment: Alignment.center,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      ),
    );
  }
}
