import 'package:get/get.dart';

import '../../../domain/entities/product/product_entity.dart';

/// Product controller for Product module UI.
class ProductController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<ProductEntity> products = <ProductEntity>[].obs;
  final RxString errorMessage = ''.obs;

  /// Currently selected sort label (e.g. "Relevance", "Price: Low to High").
  final RxString selectedSort = 'Relevance'.obs;

  /// Currently selected category filter.
  final RxString selectedCategory = 'All'.obs;

  /// Filtered list of products to be rendered in the grid.
  final RxList<ProductEntity> filteredProductList = <ProductEntity>[].obs;

  /// Image banners for the product header carousel.
  final RxList<String> productImages = <String>[].obs;

  /// Unique category labels for filters.
  final RxList<String> uniqueCategories = <String>[].obs;

  /// Internal mapping from product id to category label (for demo filters).
  final Map<String, String> _productCategory = <String, String>{};

  @override
  void onInit() {
    super.onInit();
    _loadDemoProducts();
  }

  void _loadDemoProducts() {
    final List<ProductEntity> demoProducts = <ProductEntity>[
      const ProductEntity(
        id: 'p1',
        name: 'Fresh Tomatoes 1kg',
        image: 'assets/images/tomato.png',
        price: 45,
        mrp: 60,
        description: 'Juicy red tomatoes perfect for salads and curries.',
        inStock: true,
      ),
      const ProductEntity(
        id: 'p2',
        name: 'Premium Potatoes 2kg',
        image: 'assets/images/potato.png',
        price: 70,
        mrp: 90,
        description: 'Clean, starchy potatoes ideal for fries and mash.',
        inStock: true,
      ),
      const ProductEntity(
        id: 'p3',
        name: 'Organic Carrots 500g',
        image: 'assets/images/carrot.png',
        price: 35,
        mrp: 45,
        description: 'Crunchy carrots great for snacking and juicing.',
        inStock: true,
      ),
      const ProductEntity(
        id: 'p4',
        name: 'Green Spinach Bunch',
        image: 'assets/images/spinach.png',
        price: 30,
        mrp: 40,
        description: 'Leafy spinach rich in iron and vitamins.',
        inStock: true,
      ),
      const ProductEntity(
        id: 'p5',
        name: 'Mixed Bell Peppers 500g',
        image: 'assets/images/pepper.png',
        price: 80,
        mrp: 100,
        description: 'Colourful peppers perfect for stir-fries and salads.',
        inStock: true,
      ),
    ];

    // Map demo products to categories.
    _productCategory
      ..clear()
      ..addAll(<String, String>{
        'p1': 'Vegetables',
        'p2': 'Vegetables',
        'p3': 'Vegetables',
        'p4': 'Leafy Greens',
        'p5': 'Vegetables',
      });

    products.assignAll(demoProducts);

    // Derive unique categories including "All".
    final Set<String> categories = _productCategory.values.toSet();
    uniqueCategories.assignAll(<String>['All', ...categories]);

    // Header / banner images.
    productImages.assignAll(<String>[
      'assets/images/tomato.png',
      'assets/images/potato.png',
      'assets/images/carrot.png',
    ]);

    _applyFilters();
  }

  /// Cycle sort option and apply filter.
  void applyFilter() {
    const List<String> options = <String>[
      'Relevance',
      'Price: Low to High',
      'Price: High to Low',
      'Discount',
    ];

    final int currentIndex = options.indexOf(selectedSort.value);
    final int nextIndex = currentIndex == -1
        ? 0
        : (currentIndex + 1) % options.length;
    selectedSort.value = options[nextIndex];

    _applyFilters();
  }

  /// Cycle through available categories and apply category filter.
  void applyCategoryFilter() {
    if (uniqueCategories.isEmpty) {
      return;
    }

    final int currentIndex = uniqueCategories.indexOf(selectedCategory.value);
    final int nextIndex = currentIndex == -1
        ? 0
        : (currentIndex + 1) % uniqueCategories.length;

    selectedCategory.value = uniqueCategories[nextIndex];
    _applyFilters();
  }

  void _applyFilters() {
    List<ProductEntity> list = List<ProductEntity>.from(products);

    // Category filter
    final String category = selectedCategory.value;
    if (category != 'All' && category.isNotEmpty) {
      list = list
          .where((ProductEntity p) => _productCategory[p.id] == category)
          .toList();
    }

    // Sort filter
    switch (selectedSort.value) {
      case 'Price: Low to High':
        list.sort(
          (ProductEntity a, ProductEntity b) => a.price.compareTo(b.price),
        );
        break;
      case 'Price: High to Low':
        list.sort(
          (ProductEntity a, ProductEntity b) => b.price.compareTo(a.price),
        );
        break;
      case 'Discount':
        double discount(ProductEntity p) {
          final double? mrp = p.mrp;
          if (mrp == null || mrp <= 0 || mrp <= p.price) {
            return 0;
          }
          return (mrp - p.price) / mrp;
        }

        list.sort(
          (ProductEntity a, ProductEntity b) =>
              discount(b).compareTo(discount(a)),
        );
        break;
      case 'Relevance':
      default:
        break;
    }

    filteredProductList.assignAll(list);
  }
}
