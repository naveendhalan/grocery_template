import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({super.key, required this.controller, required this.label, required this.hint, this.obscureText = false, this.keyboardType, this.prefixIcon});

  final RxString controller;
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 18, spreadRadius: 2, offset: const Offset(0, 8))],
      ),
      child: TextField(
        onChanged: (value) => controller.value = value,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: theme.colorScheme.primary) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          filled: true,
          fillColor: theme.colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
