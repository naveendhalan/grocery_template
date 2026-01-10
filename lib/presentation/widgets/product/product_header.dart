import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product/product_controller.dart';

class ProductHeader extends StatefulWidget {
  const ProductHeader({super.key});

  @override
  State<ProductHeader> createState() => _ProductHeaderState();
}

class _ProductHeaderState extends State<ProductHeader> {
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;
  int _currentPage = 0;

  ProductController get _controller => Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      final images = _controller.productImages;
      if (images.isEmpty || !_pageController.hasClients) return;

      _currentPage = (_currentPage + 1) % images.length;
      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final images = _controller.productImages;

      if (images.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 18, spreadRadius: 2, offset: const Offset(0, 8))],
        ),
        clipBehavior: Clip.antiAlias,
        child: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(images[index], fit: BoxFit.cover),
            );
          },
        ),
      );
    });
  }
}
