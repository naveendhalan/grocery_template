import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_detail_controller.dart';
import '../../widgets/product/product_detail_description.dart';
import '../../widgets/product/product_detail_disclaimer.dart';
import '../../widgets/product/product_detail_header.dart';
import '../../widgets/product/product_detail_images_carousel.dart';
import '../../widgets/product/product_detail_key_features.dart';
import '../../widgets/product/product_detail_name_price.dart';
import '../../widgets/product/product_detail_quantity_selector.dart';
import '../../widgets/product/product_detail_related_products.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              ProductDetailHeader(),
              SizedBox(height: 12),
              ProductDetailImagesCarousel(),
              SizedBox(height: 12),
              ProductDetailNamePrice(),
              SizedBox(height: 12),
              ProductDetailDescription(),
              SizedBox(height: 12),
              ProductDetailKeyFeatures(),
              SizedBox(height: 12),
              ProductDetailDisclaimer(),
              SizedBox(height: 12),
              ProductDetailQuantitySelector(),
              SizedBox(height: 16),
              ProductDetailRelatedProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
