import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_template/presentation/controllers/notification/notification_binding.dart';

import '../../../config/routes/app_routes.dart';
import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../controllers/cart/cart_binding.dart';
import '../../controllers/cart/cart_controller.dart';
import '../../controllers/notification/notification_controller.dart';
import '../../controllers/wishlist/wishlist_binding.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../widgets/category/category_card.dart';
import '../../widgets/product/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Reset to home when page is initialized
    _selectedIndex = 0;
  }

  // Static dummy data for categories
  List<CategoryEntity> get _categories => [
    const CategoryEntity(id: 'c1', name: 'Fruits', image: 'assets/images/fruits.png', description: 'Fresh and seasonal fruits'),
    const CategoryEntity(id: 'c2', name: 'Vegetables', image: 'assets/images/veg.png', description: 'Daily vegetables'),
    const CategoryEntity(id: 'c3', name: 'Dairy', image: 'assets/images/dairy.png', description: 'Milk and dairy products'),
    const CategoryEntity(id: 'c4', name: 'Snacks', image: 'assets/images/snacks.png', description: 'Crunchy snacks'),
    const CategoryEntity(id: 'c5', name: 'Bakery', image: 'assets/images/bakery.png', description: 'Bread and cakes'),
    const CategoryEntity(id: 'c6', name: 'Beverages', image: 'assets/images/beverages.png', description: 'Juices and drinks'),
  ];

  // Icon mapping for categories
  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'fruits':
        return Icons.apple;
      case 'vegetables':
        return Icons.eco;
      case 'dairy':
        return Icons.local_drink;
      case 'snacks':
        return Icons.cookie;
      case 'bakery':
        return Icons.bakery_dining;
      case 'beverages':
        return Icons.local_bar;
      default:
        return Icons.category;
    }
  }

  // Static dummy data for best selling products
  List<ProductEntity> get _bestSellingProducts => [
    const ProductEntity(id: 'p1', name: 'Fresh Tomatoes 1kg', image: 'assets/images/tomato.png', price: 45, mrp: 60, description: 'Juicy red tomatoes', inStock: true),
    const ProductEntity(id: 'p2', name: 'Premium Potatoes 2kg', image: 'assets/images/potato.png', price: 70, mrp: 90, description: 'Clean potatoes', inStock: true),
    const ProductEntity(id: 'p3', name: 'Organic Carrots 500g', image: 'assets/images/carrot.png', price: 35, mrp: 45, description: 'Crunchy carrots', inStock: true),
    const ProductEntity(id: 'p4', name: 'Green Spinach Bunch', image: 'assets/images/spinach.png', price: 30, mrp: 40, description: 'Leafy spinach', inStock: true),
  ];

  // Static dummy data for fresh products
  List<ProductEntity> get _freshProducts => [
    const ProductEntity(id: 'p5', name: 'Mixed Bell Peppers 500g', image: 'assets/images/pepper.png', price: 80, mrp: 100, description: 'Colourful peppers', inStock: true),
    const ProductEntity(id: 'p6', name: 'Fresh Broccoli 500g', image: 'assets/images/tomato.png', price: 55, mrp: 70, description: 'Fresh broccoli', inStock: true),
    const ProductEntity(id: 'p7', name: 'Organic Onions 1kg', image: 'assets/images/potato.png', price: 40, mrp: 50, description: 'Fresh onions', inStock: true),
    const ProductEntity(id: 'p8', name: 'Cucumber 500g', image: 'assets/images/carrot.png', price: 25, mrp: 35, description: 'Fresh cucumber', inStock: true),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        Get.toNamed(AppRoutes.category);
        break;
      case 2:
        Get.toNamed(AppRoutes.cart);
        break;
      case 3:
        Get.toNamed(AppRoutes.wishlist);
        break;
      case 4:
        Get.toNamed(AppRoutes.profile);
        break;
    }
  }

  void _showAddressBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.my_location,
                  color: theme.colorScheme.primary,
                ),
                title: Text(
                  'Use Current Location',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // UI only - no API integration
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: theme.colorScheme.primary,
                ),
                title: Text(
                  'Saved Addresses',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // UI only - no API integration
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ensure cart controller is available
    if (!Get.isRegistered<CartController>()) {
      CartBinding().dependencies();
    }

    // Ensure wishlist controller is available
    if (!Get.isRegistered<WishlistController>()) {
      WishlistBinding().dependencies();
    }

    // Ensure notification controller is available
    if (!Get.isRegistered<NotificationController>()) {
      NotificationBinding().dependencies();
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: theme.colorScheme.onSurface),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: InkWell(
          onTap: () => _showAddressBottomSheet(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  '123 Main Street, City',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ],
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          Obx(() {
            final cartController = Get.find<CartController>();
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: theme.colorScheme.onSurface),
                  onPressed: () => Get.toNamed(AppRoutes.cart),
                ),
                if (cartController.totalItems > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${cartController.totalItems}',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onError, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
          Obx(() {
            final notificationController = Get.find<NotificationController>();
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_outlined, color: theme.colorScheme.onSurface),
                  onPressed: () => Get.toNamed(AppRoutes.notification),
                ),
                if (notificationController.unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${notificationController.unreadCount}',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onError, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Grocery App',
                    style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: theme.colorScheme.onSurface),
              title: Text('Home', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.category, color: theme.colorScheme.onSurface),
              title: Text('Categories', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppRoutes.category);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: theme.colorScheme.onSurface),
              title: Text('Cart', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppRoutes.cart);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: theme.colorScheme.onSurface),
              title: Text('Wishlist', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppRoutes.wishlist);
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: theme.colorScheme.onSurface),
              title: Text('Profile', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppRoutes.profile);
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_long, color: theme.colorScheme.onSurface),
              title: Text('Orders', style: TextStyle(color: theme.colorScheme.onSurface)),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppRoutes.orders);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () => Get.toNamed(AppRoutes.search),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: theme.colorScheme.onSurface.withOpacity(0.6)),
                        const SizedBox(width: 12),
                        Text('Search for products...', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
                      ],
                    ),
                  ),
                ),
              ),

              // Category Horizontal List
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: Text(
                  'Categories',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 90,
                        child: CategoryCard(
                          category: category,
                          icon: _getCategoryIcon(category.name),
                          onTap: () => Get.toNamed(AppRoutes.category),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Promotional Banner Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primaryContainer,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Special Offer',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Get 20% off on your first order!',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary.withOpacity(0.85),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Best Selling Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Selling',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.productList),
                      child: Text(
                        'See All',
                        style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _bestSellingProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(width: 160, child: ProductCard(product: _bestSellingProducts[index])),
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Fresh for You Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fresh for You',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.productList),
                      child: Text(
                        'See All',
                        style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _freshProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(width: 160, child: ProductCard(product: _freshProducts[index])),
                    );
                  },
                ),
              ),

              const SizedBox(height: 80), // Space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        final cartController = Get.find<CartController>();
        return BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
          backgroundColor: theme.colorScheme.surface,
          elevation: 8,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.category_outlined), activeIcon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  if (cartController.totalItems > 0)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        padding: cartController.totalItems > 9 ? const EdgeInsets.symmetric(horizontal: 4, vertical: 2) : const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          cartController.totalItems > 9 ? '9+' : '${cartController.totalItems}',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onError, fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_cart),
                  if (cartController.totalItems > 0)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        padding: cartController.totalItems > 9 ? const EdgeInsets.symmetric(horizontal: 4, vertical: 2) : const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          cartController.totalItems > 9 ? '9+' : '${cartController.totalItems}',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onError, fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'Wishlist'),
            const BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      }),
    );
  }
}
