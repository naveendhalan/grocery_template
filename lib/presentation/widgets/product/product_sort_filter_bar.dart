import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product/product_controller.dart';

class ProductSortFilterBar extends GetView<ProductController> {
  const ProductSortFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: controller.applyFilter,
              child: Obx(
                () => Row(
                  children: <Widget>[
                    Text(
                      'Sort: ${controller.selectedSort.value}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: controller.applyCategoryFilter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.filter_list_rounded,
                  size: 18,
                  color: theme.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  'Filter',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



