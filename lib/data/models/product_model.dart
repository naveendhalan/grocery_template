import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({required super.id, required super.name, required super.image, required super.description, required super.price, required super.rating});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    image: json['image']?.toString() ?? '',
    description: json['description']?.toString() ?? '',
    price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
    rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image, 'description': description, 'price': price, 'rating': rating};

  ProductModel copyWith({String? id, String? name, String? image, String? description, double? price, double? rating}) {
    return ProductModel(id: id ?? this.id, name: name ?? this.name, image: image ?? this.image, description: description ?? this.description, price: price ?? this.price, rating: rating ?? this.rating);
  }
}
