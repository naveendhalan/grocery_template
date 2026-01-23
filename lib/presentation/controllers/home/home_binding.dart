import 'package:get/get.dart';

import '../../../data/datasources/home/home_remote_ds.dart';
import '../../../data/repositories/home/home_repository_impl.dart';
import '../../../domain/repositories/home/home_repository.dart';
import '../../../domain/usecases/home/get_home_data.dart';
import '../cart/cart_binding.dart';
import '../cart/cart_controller.dart';
import '../checkout/checkout_binding.dart';
import '../checkout/checkout_controller.dart';
import '../profile/profile_binding.dart';
import '../profile/profile_controller.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Data source layer
    Get.lazyPut<HomeRemoteDataSource>(() => HomeRemoteDataSource(), fenix: true);
    
    // Repository layer - register implementation as abstract interface
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(Get.find<HomeRemoteDataSource>()),
      fenix: true,
    );
    
    // Use case layer
    Get.lazyPut<GetHomeData>(
      () => GetHomeData(Get.find<HomeRepository>()),
      fenix: true,
    );
    
    // Controller layer
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<GetHomeData>()),
      fenix: true,
    );
    
    // Ensure cart controller is available (required by CheckoutController)
    if (!Get.isRegistered<CartController>()) {
      CartBinding().dependencies();
    }
    
    // Ensure profile controller is available for address management
    if (!Get.isRegistered<ProfileController>()) {
      ProfileBinding().dependencies();
    }
    
    // Initialize CheckoutController early so Home can use selectedAddress
    if (!Get.isRegistered<CheckoutController>()) {
      CheckoutBinding().dependencies();
    }
  }
}
