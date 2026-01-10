import 'package:flutter/material.dart';

class HomeBannerWidget extends StatelessWidget {
  final List banners;

  const HomeBannerWidget({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (_, index) {
          return Image.asset(banners[index].imageUrl, fit: BoxFit.cover);
        },
      ),
    );
  }
}
