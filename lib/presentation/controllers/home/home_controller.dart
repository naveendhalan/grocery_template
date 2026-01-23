import 'package:get/get.dart';

import '../../../domain/entities/banner_entity.dart';
import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../../domain/usecases/home/get_home_data.dart';

class HomeController extends GetxController {
  final GetHomeData getHomeData;

  final RxList<BannerEntity> banners = <BannerEntity>[].obs;
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final RxList<ProductEntity> products = <ProductEntity>[].obs;

  final RxBool isLoading = false.obs;

  HomeController(this.getHomeData);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      final result = await getHomeData();
      banners.value = result.banners;
      categories.value = result.categories;
      products.value = result.products;
    } finally {
      isLoading.value = false;
    }
  }
}
