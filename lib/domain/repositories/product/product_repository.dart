import '../../entities/product/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
}
