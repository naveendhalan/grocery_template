class ProductEntity {
  final String id;
  final String name;
  final String image;
  final double price;
  final double? mrp;
  final String? description;
  final bool inStock;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.mrp,
    this.description,
    required this.inStock,
  });
}
