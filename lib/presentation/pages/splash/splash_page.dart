import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../config/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _version = '1.0.0';
  String _buildNumber = '1';

  @override
  void initState() {
    super.initState();
    _loadVersionInfo();
    _navigateToHome();
  }

  Future<void> _loadVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.shopping_cart, size: 100, color: theme.colorScheme.onSurface.withOpacity(0.3));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                children: [
                  Text('Designed & Developed by: Naveen Chaudhary', style: theme.textTheme.bodySmall?.copyWith(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                  const SizedBox(height: 4),
                  Text('Version: $_version($_buildNumber)', style: theme.textTheme.bodySmall?.copyWith(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
