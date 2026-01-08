import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth/forgot_password_controller.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../widgets/auth/auth_button.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Forgot Password?',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your phone or email to receive a password reset link',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AuthTextField(
                controller: controller.phoneOrEmail,
                label: 'Phone or Email',
                hint: 'Enter your phone or email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.phone_android_outlined,
              ),
              const SizedBox(height: 32),
              Obx(
                () => AuthButton(
                  text: 'Send Reset Link',
                  onPressed: controller.sendResetLink,
                  isEnabled: controller.isValid,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
