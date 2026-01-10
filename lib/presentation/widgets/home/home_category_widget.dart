import 'package:flutter/material.dart';

class HomeCategoryWidget extends StatelessWidget {
  final List categories;

  const HomeCategoryWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, i) {
          return Column(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage(categories[i].image)),
              Text(categories[i].title),
            ],
          );
        },
      ),
    );
  }
}
