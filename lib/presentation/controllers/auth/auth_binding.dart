import 'package:get/get.dart';
import 'login_controller.dart';
import 'otp_controller.dart';
import 'forgot_password_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => OtpController());
    Get.lazyPut(() => ForgotPasswordController());
  }
}
