import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/otp_controller.dart';
import '../../widgets/auth/auth_button.dart';

class OtpPage extends GetView<OtpController> {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              Text(
                'Verify OTP',
                style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                controller.phoneOrEmail != null ? 'Enter the OTP sent to\n${controller.phoneOrEmail}' : 'Enter the OTP sent to your phone/email',
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),
              Container(
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 18, spreadRadius: 2, offset: const Offset(0, 8))],
                ),
                child: TextField(
                  onChanged: (value) {
                    if (value.length <= 6) {
                      controller.otp.value = value;
                    }
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: Get.theme.textTheme.bodyLarge?.copyWith(color: Get.theme.colorScheme.onSurface, letterSpacing: 8),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    hintText: 'Enter 6-digit OTP',
                    prefixIcon: Icon(Icons.lock_outline, color: Get.theme.colorScheme.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Get.theme.colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Obx(() => AuthButton(text: 'Verify', onPressed: controller.verifyOtp, isEnabled: controller.isValid)),
            ],
          ),
        ),
      ),
    );
  }
}
