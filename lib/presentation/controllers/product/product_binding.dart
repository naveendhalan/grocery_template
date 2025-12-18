import 'package:get/get.dart';

import '../../../data/datasources/product/product_remote_datasource.dart';
import '../../../data/repositories/product/product_repository_impl.dart';
import '../../../domain/usecases/product/get_products_usecase.dart';
import 'product_controller.dart';
import '../product_detail_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSource(),
      fenix: true,
    );

    // Repositories
    Get.lazyPut<ProductRepositoryImpl>(
      () => ProductRepositoryImpl(Get.find<ProductRemoteDataSource>()),
      fenix: true,
    );

    // Use cases
    Get.lazyPut<GetProductsUseCase>(
      () => GetProductsUseCase(Get.find<ProductRepositoryImpl>()),
      fenix: true,
    );

    // Controllers
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
      fenix: true,
    );
  }
}
