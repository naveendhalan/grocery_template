import 'package:get/get.dart';
import '../../../config/routes/app_routes.dart';

class LoginController extends GetxController {
  final RxString phoneOrEmail = ''.obs;
  final RxString password = ''.obs;

  bool get isValid =>
      phoneOrEmail.value.isNotEmpty && password.value.isNotEmpty;

  void login() {
    if (isValid) {
      Get.toNamed(AppRoutes.otp, arguments: phoneOrEmail.value);
    }
  }

  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }
}
