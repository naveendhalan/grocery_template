class ReviewEntity {
  final String productId;
  final String productName;
  final String productImage;
  final int rating; // 1-5
  final String reviewText;
  final List<String> imagePaths; // local paths or base64 strings for template
  final DateTime createdAt;

  ReviewEntity({required this.productId, required this.productName, required this.productImage, required this.rating, required this.reviewText, required this.imagePaths, required this.createdAt});
}
