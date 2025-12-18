import '../../models/banner_model.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

class HomeRemoteDataSource {
  Future<List<BannerModel>> getBanners() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      BannerModel(imageUrl: 'assets/images/banner1.png'),
      BannerModel(imageUrl: 'assets/images/banner2.png'),
    ];
  }

  Future<List<CategoryModel>> getCategories() async {
    return [
      CategoryModel(id: "1", title: "Vegetables", image: "assets/images/veg.png"),
      CategoryModel(id: "2", title: "Fruits", image: "assets/images/fruits.png"),
    ];
  }

  Future<List<ProductModel>> getProducts() async {
    return [
      ProductModel(
        id: "101",
        name: "Potato",
        image: "assets/images/potato.png",
        description: "High-quality potatoes, ideal for frying, boiling, or baking.",
        price: 20,
        rating: 4.2,
      ),
      ProductModel(
        id: "102",
        name: "Tomato",
        image: "assets/images/tomato.png",
        description: "Fresh, juicy organic tomatoes picked from local farms.",
        price: 30,
        rating: 4.5,
      ),
    ];
  }
}
