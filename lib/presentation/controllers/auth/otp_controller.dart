import 'package:get/get.dart';

import '../../../config/routes/app_routes.dart';

class OtpController extends GetxController {
  final RxString otp = ''.obs;
  String? phoneOrEmail;

  @override
  void onInit() {
    super.onInit();
    phoneOrEmail = Get.arguments as String?;
  }

  bool get isValid => otp.value.length == 6;

  void verifyOtp() {
    if (isValid) {
      Get.offNamed(AppRoutes.home);
    }
  }
}
