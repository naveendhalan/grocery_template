import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final int totalPages = 3;

  void updatePage(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      skip();
    }
  }

  void skip() {
    Get.offNamed(AppRoutes.login);
  }

  bool get isLastPage => currentPage.value == totalPages - 1;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
