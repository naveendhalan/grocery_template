import 'package:get/get.dart';

import '../../../domain/usecases/home/get_home_data.dart';

class HomeController extends GetxController {
  final GetHomeData getHomeData;

  var banners = [].obs;
  var categories = [].obs;
  var products = [].obs;

  var isLoading = false.obs;

  HomeController(this.getHomeData);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading(true);
    final result = await getHomeData();
    banners.assignAll(result.banners);
    categories.assignAll(result.categories);
    products.assignAll(result.products);
    isLoading(false);
  }
}
