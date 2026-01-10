import '../../../domain/entities/category/category_entity.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String description;

  const CategoryModel({required this.id, required this.name, required this.image, required this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id']?.toString() ?? '', name: json['name']?.toString() ?? '', image: json['image']?.toString() ?? '', description: json['description']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'image': image, 'description': description};
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name, image: image, description: description);
  }
}
