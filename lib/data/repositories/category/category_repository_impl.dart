import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/repositories/category/category_repository.dart';
import '../../datasources/category/category_local_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final models = await localDataSource.getCategories();
    return models.map((m) => m.toEntity()).toList();
  }
}
