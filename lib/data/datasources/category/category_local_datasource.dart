import '../../models/category/category_model.dart';

class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories() async {
    // Simulate small delay to mimic IO.
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return <CategoryModel>[
      const CategoryModel(id: 'c1', name: 'Fruits', image: 'assets/images/fruits.png', description: 'Fresh and seasonal fruits for everyday nutrition.'),
      const CategoryModel(id: 'c2', name: 'Vegetables', image: 'assets/images/veg.png', description: 'Daily vegetables, leafy greens and more.'),
      const CategoryModel(id: 'c3', name: 'Dairy', image: 'assets/images/dairy.png', description: 'Milk, paneer, curd and other dairy products.'),
      const CategoryModel(id: 'c4', name: 'Snacks', image: 'assets/images/snacks.png', description: 'Crunchy snacks and quick bites.'),
      const CategoryModel(id: 'c5', name: 'Bakery', image: 'assets/images/bakery.png', description: 'Bread, buns, cakes and more.'),
      const CategoryModel(id: 'c6', name: 'Beverages', image: 'assets/images/beverages.png', description: 'Juices, soft drinks and refreshing beverages.'),
    ];
  }
}
