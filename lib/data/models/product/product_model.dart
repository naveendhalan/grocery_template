import '../../../domain/entities/product/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({required super.id, required super.name, required super.image, required super.price, super.mrp, super.description, required super.inStock});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      mrp: json['mrp'] == null
          ? null
          : (json['mrp'] is num)
          ? (json['mrp'] as num).toDouble()
          : double.tryParse(json['mrp']?.toString() ?? ''),
      description: json['description']?.toString(),
      inStock: json['inStock'] is bool ? json['inStock'] as bool : json['inStock']?.toString() == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'image': image, 'price': price, 'mrp': mrp, 'description': description, 'inStock': inStock};
  }

  ProductModel copyWith({String? id, String? name, String? image, double? price, double? mrp, String? description, bool? inStock}) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      mrp: mrp ?? this.mrp,
      description: description ?? this.description,
      inStock: inStock ?? this.inStock,
    );
  }
}
