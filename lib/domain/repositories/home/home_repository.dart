import '../../entities/banner_entity.dart';
import '../../entities/category_entity.dart';
import '../../entities/product_entity.dart';

class HomeDataBundle {
  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;

  HomeDataBundle({required this.banners, required this.categories, required this.products});
}

abstract class HomeRepository {
  Future<HomeDataBundle> getHomeData();
}
