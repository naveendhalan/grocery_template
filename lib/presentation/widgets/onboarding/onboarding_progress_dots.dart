import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding/onboarding_controller.dart';

class OnboardingProgressDots extends StatelessWidget {
  const OnboardingProgressDots({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final theme = Theme.of(context);

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.totalPages,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: index == controller.currentPage.value ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: index == controller.currentPage.value ? theme.colorScheme.primary : theme.colorScheme.primary.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}
