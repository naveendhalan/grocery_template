import '../../../domain/entities/product/product_entity.dart';
import '../../../domain/repositories/product/product_repository.dart';
import '../../datasources/product/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    // Remote layer returns ProductModel which extends ProductEntity,
    // so it can be returned directly as a list of ProductEntity.
    return remoteDataSource.getProducts();
  }
}
