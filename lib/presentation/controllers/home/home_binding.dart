import 'package:get/get.dart';

import '../../../data/datasources/home/home_remote_ds.dart';
import '../../../data/repositories/home/home_repository_impl.dart';
import '../../../domain/usecases/home/get_home_data.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeRemoteDataSource());
    Get.lazyPut(() => HomeRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetHomeData(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
