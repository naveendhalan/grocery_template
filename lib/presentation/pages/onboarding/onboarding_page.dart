import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding/onboarding_controller.dart';
import '../../widgets/onboarding/onboarding_progress_dots.dart';
import '../../widgets/onboarding/onboarding_slide.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.updatePage,
                children: const [
                  OnboardingSlide(
                    imagePath: 'assets/images/onboarding1.png',
                    title: 'Welcome to Grocery Store',
                    subtitle: 'Discover fresh groceries and essentials delivered right to your doorstep. Shop with ease and convenience.',
                  ),
                  OnboardingSlide(imagePath: 'assets/images/onboarding2.png', title: 'Browse Categories', subtitle: 'Explore a wide range of products organized by categories. Find exactly what you need in seconds.'),
                  OnboardingSlide(
                    imagePath: 'assets/images/onboarding3.png',
                    title: 'Fast Delivery',
                    subtitle: 'Get your groceries delivered quickly and safely. Track your order in real-time and enjoy hassle-free shopping.',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const OnboardingProgressDots(),
                  const SizedBox(height: 24),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: controller.skip,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            'Skip',
                            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.w600),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: controller.nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 2,
                            shadowColor: Colors.black12.withOpacity(0.08),
                          ),
                          child: Text(
                            controller.isLastPage ? 'Done' : 'Next',
                            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
