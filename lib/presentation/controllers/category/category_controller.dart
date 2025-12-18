import 'package:get/get.dart';

import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/usecases/category/get_categories_usecase.dart';

class CategoryController extends GetxController {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryController(this.getCategoriesUseCase);

  final RxBool isLoading = false.obs;
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getCategoriesUseCase();
      categories.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to load categories';
      categories.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
