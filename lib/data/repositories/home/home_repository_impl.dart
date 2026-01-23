import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/repositories/home/home_repository.dart';
import '../../datasources/home/home_remote_ds.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<HomeDataBundle> getHomeData() async {
    final banners = await remote.getBanners();
    final categoryModels = await remote.getCategories();
    final products = await remote.getProducts();

    // Convert CategoryModel to CategoryEntity
    final categories = categoryModels.map((model) => model.toEntity()).toList();

    return HomeDataBundle(banners: banners, categories: categories, products: products);
  }
}
