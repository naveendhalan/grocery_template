import '../../../domain/repositories/home/home_repository.dart';
import '../../datasources/home/home_remote_ds.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<HomeDataBundle> getHomeData() async {
    final banners = await remote.getBanners();
    final categories = await remote.getCategories();
    final products = await remote.getProducts();

    return HomeDataBundle(
      banners: banners,
      categories: categories,
      products: products,
    );
  }
}
