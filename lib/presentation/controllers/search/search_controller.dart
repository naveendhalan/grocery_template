import 'package:get/get.dart';

import '../../../domain/entities/filter_entity.dart';
import '../../../domain/entities/product/product_entity.dart';

class SearchController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxList<ProductEntity> searchResults = <ProductEntity>[].obs;
  final RxList<FilterEntity> selectedFilters = <FilterEntity>[].obs;

  // Demo products for search
  final List<ProductEntity> _allProducts = [
    const ProductEntity(id: 'p1', name: 'Fresh Tomatoes 1kg', image: 'assets/images/tomato.png', price: 45, mrp: 60, description: 'Juicy red tomatoes perfect for salads and curries.', inStock: true),
    const ProductEntity(id: 'p2', name: 'Premium Potatoes 2kg', image: 'assets/images/potato.png', price: 70, mrp: 90, description: 'Clean, starchy potatoes ideal for fries and mash.', inStock: true),
    const ProductEntity(id: 'p3', name: 'Organic Carrots 500g', image: 'assets/images/carrot.png', price: 35, mrp: 45, description: 'Crunchy carrots great for snacking and juicing.', inStock: true),
    const ProductEntity(id: 'p4', name: 'Green Spinach Bunch', image: 'assets/images/spinach.png', price: 30, mrp: 40, description: 'Leafy spinach rich in iron and vitamins.', inStock: true),
    const ProductEntity(id: 'p5', name: 'Mixed Bell Peppers 500g', image: 'assets/images/pepper.png', price: 80, mrp: 100, description: 'Colourful peppers perfect for stir-fries and salads.', inStock: true),
    const ProductEntity(id: 'p6', name: 'Fresh Broccoli 500g', image: 'assets/images/broccoli.png', price: 55, mrp: 70, description: 'Nutritious broccoli packed with vitamins.', inStock: true),
    const ProductEntity(id: 'p7', name: 'Crisp Lettuce Head', image: 'assets/images/lettuce.png', price: 25, mrp: 35, description: 'Fresh lettuce for salads and wraps.', inStock: true),
    const ProductEntity(id: 'p8', name: 'Sweet Corn 4 pieces', image: 'assets/images/corn.png', price: 40, mrp: 50, description: 'Sweet and juicy corn on the cob.', inStock: true),
  ];

  // Available filters
  final List<FilterEntity> availableFilters = [
    // Category filters
    const FilterEntity(id: 'cat1', name: 'Vegetables', type: FilterType.category, value: 'Vegetables'),
    const FilterEntity(id: 'cat2', name: 'Leafy Greens', type: FilterType.category, value: 'Leafy Greens'),
    // Price filters
    const FilterEntity(id: 'price1', name: 'Under ₹30', type: FilterType.price, value: '0-30'),
    const FilterEntity(id: 'price2', name: '₹30 - ₹50', type: FilterType.price, value: '30-50'),
    const FilterEntity(id: 'price3', name: '₹50 - ₹70', type: FilterType.price, value: '50-70'),
    const FilterEntity(id: 'price4', name: 'Above ₹70', type: FilterType.price, value: '70+'),
    // Rating filters
    const FilterEntity(id: 'rating1', name: '4+ Stars', type: FilterType.rating, value: '4'),
    const FilterEntity(id: 'rating2', name: '3+ Stars', type: FilterType.rating, value: '3'),
  ];

  // Product category mapping
  final Map<String, String> _productCategory = {'p1': 'Vegetables', 'p2': 'Vegetables', 'p3': 'Vegetables', 'p4': 'Leafy Greens', 'p5': 'Vegetables', 'p6': 'Vegetables', 'p7': 'Leafy Greens', 'p8': 'Vegetables'};

  @override
  void onInit() {
    super.onInit();
    searchResults.assignAll(_allProducts);
  }

  void updateQuery(String value) {
    searchQuery.value = value;
    _performSearch();
  }

  void applyFilters(List<FilterEntity> filters) {
    selectedFilters.assignAll(filters);
    _performSearch();
  }

  void clearFilters() {
    selectedFilters.clear();
    _performSearch();
  }

  void _performSearch() {
    List<ProductEntity> results = List<ProductEntity>.from(_allProducts);

    // Apply search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      results = results.where((product) => product.name.toLowerCase().contains(query) || (product.description?.toLowerCase().contains(query) ?? false)).toList();
    }

    // Apply filters
    for (final filter in selectedFilters) {
      switch (filter.type) {
        case FilterType.category:
          if (filter.value != null) {
            results = results.where((product) => _productCategory[product.id] == filter.value).toList();
          }
          break;
        case FilterType.price:
          if (filter.value != null) {
            final priceRange = filter.value!.split('-');
            if (priceRange.length == 2) {
              final min = double.tryParse(priceRange[0]) ?? 0;
              final max = double.tryParse(priceRange[1]) ?? double.infinity;
              results = results.where((product) => product.price >= min && product.price <= max).toList();
            } else if (filter.value!.contains('+')) {
              final min = double.tryParse(filter.value!.replaceAll('+', '')) ?? 0;
              results = results.where((product) => product.price >= min).toList();
            }
          }
          break;
        case FilterType.rating:
          // Demo rating filter (assuming all products have 4+ rating for demo)
          // In real app, this would check actual product ratings
          break;
      }
    }

    searchResults.assignAll(results);
  }

  bool isFilterSelected(String filterId) {
    return selectedFilters.any((filter) => filter.id == filterId);
  }

  void toggleFilter(FilterEntity filter) {
    if (isFilterSelected(filter.id)) {
      selectedFilters.removeWhere((f) => f.id == filter.id);
    } else {
      selectedFilters.add(filter);
    }
  }
}
