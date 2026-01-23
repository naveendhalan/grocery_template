import '../../models/banner_model.dart';
import '../../models/category/category_model.dart';
import '../../models/product/product_model.dart';

class HomeRemoteDataSource {
  Future<List<BannerModel>> getBanners() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [BannerModel(imageUrl: 'assets/images/banner1.png'), BannerModel(imageUrl: 'assets/images/banner2.png')];
  }

  Future<List<CategoryModel>> getCategories() async {
    return [
      const CategoryModel(id: "1", name: "Vegetables", image: "assets/images/veg.png", description: "Fresh vegetables"),
      const CategoryModel(id: "2", name: "Fruits", image: "assets/images/fruits.png", description: "Fresh fruits"),
    ];
  }

  Future<List<ProductModel>> getProducts() async {
    return [
      const ProductModel(id: "101", name: "Potato", image: "assets/images/potato.png", price: 20, mrp: 25, description: "High-quality potatoes, ideal for frying, boiling, or baking.", inStock: true),
      const ProductModel(id: "102", name: "Tomato", image: "assets/images/tomato.png", price: 30, mrp: 35, description: "Fresh, juicy organic tomatoes picked from local farms.", inStock: true),
    ];
  }
}
