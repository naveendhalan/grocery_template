import 'package:get/get.dart';

import '../../../data/datasources/category/category_local_datasource.dart';
import '../../../data/repositories/category/category_repository_impl.dart';
import '../../../domain/usecases/category/get_categories_usecase.dart';
import 'category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.lazyPut<CategoryLocalDataSource>(() => CategoryLocalDataSource(), fenix: true);

    // Repository
    Get.lazyPut<CategoryRepositoryImpl>(() => CategoryRepositoryImpl(Get.find<CategoryLocalDataSource>()), fenix: true);

    // Usecase
    Get.lazyPut<GetCategoriesUseCase>(() => GetCategoriesUseCase(Get.find<CategoryRepositoryImpl>()), fenix: true);

    // Controller
    Get.lazyPut<CategoryController>(() => CategoryController(Get.find<GetCategoriesUseCase>()), fenix: true);
  }
}
