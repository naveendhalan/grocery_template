import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/login_controller.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_field.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

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
                'Welcome Back',
                style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AuthTextField(controller: controller.phoneOrEmail, label: 'Phone or Email', hint: 'Enter your phone or email', keyboardType: TextInputType.emailAddress, prefixIcon: Icons.phone_android_outlined),
              const SizedBox(height: 20),
              AuthTextField(controller: controller.password, label: 'Password', hint: 'Enter your password', obscureText: true, prefixIcon: Icons.lock_outline),

              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.navigateToForgotPassword,
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                  child: Text(
                    'Forgot Password?',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Obx(() => AuthButton(text: 'Login', onPressed: controller.login, isEnabled: controller.isValid)),
            ],
          ),
        ),
      ),
    );
  }
}
