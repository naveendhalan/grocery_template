import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../widgets/auth/auth_button.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final name = controller.name.value.obs;
    final email = controller.email.value.obs;
    final phone = controller.phone.value.obs;

    // Initialize values
    name.value = controller.name.value;
    email.value = controller.email.value;
    phone.value = controller.phone.value;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                controller: name,
                label: 'Name',
                hint: 'Enter your name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              AuthTextField(
                  controller: email,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
              const SizedBox(height: 20),
              AuthTextField(
                  controller: phone,
                  label: 'Phone',
                  hint: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                ),
              const SizedBox(height: 32),
              AuthButton(
                  text: 'Save Changes',
                  onPressed: () {
                    controller.updateProfile(
                      newName: name.value,
                      newEmail: email.value,
                      newPhone: phone.value,
                    );
                  },
                  isEnabled:
                      name.value.isNotEmpty &&
                      email.value.isNotEmpty &&
                      phone.value.isNotEmpty,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
