import 'package:get/get.dart';
import '../../../data/datasources/order_local_datasource.dart';
import '../../../data/repositories/order_repository_impl.dart';
import '../../../domain/usecases/get_orders_usecase.dart';
import '../../../domain/usecases/get_order_detail_usecase.dart';
import 'orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderLocalDataSource>(() => OrderLocalDataSource(), fenix: true);
    Get.lazyPut<OrderRepositoryImpl>(() => OrderRepositoryImpl(Get.find<OrderLocalDataSource>()), fenix: true);
    Get.lazyPut<GetOrdersUseCase>(() => GetOrdersUseCase(Get.find<OrderRepositoryImpl>()), fenix: true);
    Get.lazyPut<GetOrderDetailUseCase>(() => GetOrderDetailUseCase(Get.find<OrderRepositoryImpl>()), fenix: true);
    Get.lazyPut<OrdersController>(() => OrdersController(
      getOrdersUseCase: Get.find<GetOrdersUseCase>(),
      getOrderDetailUseCase: Get.find<GetOrderDetailUseCase>(),
    ), fenix: true);
  }
}
