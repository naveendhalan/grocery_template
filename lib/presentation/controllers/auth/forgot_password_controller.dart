import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final RxString phoneOrEmail = ''.obs;

  bool get isValid => phoneOrEmail.value.isNotEmpty;

  void sendResetLink() {
    if (isValid) {
      Get.back();
      Get.snackbar(
        'Success',
        'Password reset link sent to ${phoneOrEmail.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    }
  }
}
