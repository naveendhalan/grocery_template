import 'package:flutter/material.dart';

class HomeProductWidget extends StatelessWidget {
  final List products;

  const HomeProductWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, index) {
        final p = products[index];
        return Card(
          child: Column(
            children: [
              Image.asset(p.image, height: 80),
              Text(p.name),
              Text("₹${p.price}"),
            ],
          ),
        );
      },
    );
  }
}
