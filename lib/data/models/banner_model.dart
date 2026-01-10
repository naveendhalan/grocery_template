import '../../domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({required super.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(imageUrl: json['imageUrl']);
}
