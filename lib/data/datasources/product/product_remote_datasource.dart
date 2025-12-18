import '../../models/product/product_model.dart';

/// Remote data source for products.
///
/// In this template, it returns an in-memory list of dummy products.
class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 400));

    return <ProductModel>[
      const ProductModel(
        id: '1',
        name: 'Organic Tomatoes',
        image: 'assets/images/tomato.png',
        price: 45.0,
        mrp: 55.0,
        description: 'Fresh organic tomatoes, perfect for salads and cooking.',
        inStock: true,
      ),
      const ProductModel(
        id: '2',
        name: 'Farm Potatoes',
        image: 'assets/images/potato.png',
        price: 30.0,
        mrp: 38.0,
        description: 'Clean, starchy potatoes ideal for fries and curries.',
        inStock: true,
      ),
      const ProductModel(
        id: '3',
        name: 'Fresh Carrots',
        image: 'assets/images/carrot.png',
        price: 25.0,
        mrp: 32.0,
        description: 'Crunchy carrots, great for snacking and juicing.',
        inStock: true,
      ),
      const ProductModel(
        id: '4',
        name: 'Green Spinach',
        image: 'assets/images/spinach.png',
        price: 40.0,
        mrp: 48.0,
        description: 'Leafy spinach, rich in iron and vitamins.',
        inStock: true,
      ),
      const ProductModel(
        id: '5',
        name: 'Mixed Bell Peppers',
        image: 'assets/images/pepper.png',
        price: 60.0,
        mrp: 70.0,
        description: 'Colourful peppers, perfect for stir-fries and salads.',
        inStock: false,
      ),
    ];
  }
}

