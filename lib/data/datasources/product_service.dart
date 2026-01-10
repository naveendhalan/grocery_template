import '../models/product_model.dart';

class ProductService {
  /// Fetches a list of dummy products
  Future<List<ProductModel>> fetchProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      ProductModel(
        id: '1',
        name: 'Fresh Organic Tomatoes',
        image: 'assets/images/tomato.png',
        description: 'Fresh, juicy organic tomatoes picked from local farms. Perfect for salads, cooking, and snacking.',
        price: 45.99,
        rating: 4.5,
      ),
      ProductModel(
        id: '2',
        name: 'Premium Potatoes',
        image: 'assets/images/potato.png',
        description: 'High-quality potatoes, ideal for frying, boiling, or baking. Rich in nutrients and flavor.',
        price: 35.50,
        rating: 4.2,
      ),
      ProductModel(
        id: '3',
        name: 'Fresh Carrots',
        image: 'assets/images/carrot.png',
        description: 'Crisp and sweet carrots, packed with vitamins. Great for salads, juicing, or as a healthy snack.',
        price: 28.75,
        rating: 4.7,
      ),
      ProductModel(
        id: '4',
        name: 'Organic Spinach',
        image: 'assets/images/spinach.png',
        description: 'Fresh organic spinach leaves, perfect for salads, smoothies, and cooking. Rich in iron and vitamins.',
        price: 42.00,
        rating: 4.6,
      ),
      ProductModel(
        id: '5',
        name: 'Sweet Bell Peppers',
        image: 'assets/images/pepper.png',
        description: 'Colorful bell peppers in red, yellow, and green. Sweet and crunchy, perfect for stir-fries and salads.',
        price: 55.25,
        rating: 4.4,
      ),
      ProductModel(
        id: '6',
        name: 'Fresh Broccoli',
        image: 'assets/images/broccoli.png',
        description: 'Nutritious broccoli florets, rich in fiber and vitamins. Great steamed, roasted, or in salads.',
        price: 48.50,
        rating: 4.3,
      ),
      ProductModel(
        id: '7',
        name: 'Crisp Lettuce',
        image: 'assets/images/lettuce.png',
        description: 'Fresh, crisp lettuce leaves perfect for salads and wraps. Light, refreshing, and nutritious.',
        price: 32.00,
        rating: 4.1,
      ),
      ProductModel(id: '8', name: 'Fresh Cucumbers', image: 'assets/images/cucumber.png', description: 'Cool and refreshing cucumbers, perfect for salads, pickling, or as a healthy snack.', price: 25.75, rating: 4.5),
    ];
  }

  /// Fetches a single product by ID
  Future<ProductModel?> fetchProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final products = await fetchProducts();
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
