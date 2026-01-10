import 'package:flutter/material.dart';

class HomeStoreSection extends StatelessWidget {
  const HomeStoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text("Popular Stores", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),

        SizedBox(
          height: 120,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  image: const DecorationImage(image: AssetImage("assets/store.jpg"), fit: BoxFit.cover),
                ),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemCount: 6,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
