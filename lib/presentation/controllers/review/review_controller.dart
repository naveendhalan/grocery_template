import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/review_entity.dart';
import 'package:image_picker/image_picker.dart';

class ReviewController extends GetxController {
  // Inputs/state for the multi-step flow
  final RxInt step = 1.obs; // 1..4
  final RxInt rating = 5.obs;
  final RxString reviewText = ''.obs;
  final RxList<String> imagePaths = <String>[].obs; // dummy strings for template
  final RxBool isSubmitting = false.obs;
  final ImagePicker _picker = ImagePicker();

  // product context (passed via arguments)
  late final String productId;
  late final String productName;
  late final String productImage;

  @override
  void onInit() {
    super.onInit();
    _loadFromArguments();
  }

  void _loadFromArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      productId = args['productId']?.toString() ?? '';
      productName = args['productName']?.toString() ?? '';
      productImage = args['productImage']?.toString() ?? '';
    } else {
      productId = '';
      productName = '';
      productImage = '';
    }
  }

  bool get isLastStep => step.value == 4;
  bool get isFirstStep => step.value == 1;

  void nextStep() {
    if (step.value < 4) step.value++;
  }

  void prevStep() {
    if (step.value > 1) step.value--;
  }

  void setRating(int r) => rating.value = r;
  void setReviewText(String t) => reviewText.value = t;





  Future<void> addImageFromGallery() async {
    if (imagePaths.length >= 4) {
      Get.snackbar('Limit Reached', 'You can upload up to 4 images.');
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePaths.add(image.path);
    }
  }

  Future<void> addImageFromCamera() async {
    if (imagePaths.length >= 4) {
      Get.snackbar('Limit Reached', 'You can upload up to 4 images.');
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePaths.add(image.path);
    }
  }


  void removeImageAt(int index) {
    if (index >= 0 && index < imagePaths.length) imagePaths.removeAt(index);
  }

  // Submit the review (local demo; no API)
  Future<void> submitReview() async {
    if (rating.value <= 0) {
      Get.snackbar('Validation', 'Please provide a rating.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    isSubmitting.value = true;

    // Simulate delay
    await Future<void>.delayed(const Duration(seconds: 1));

    final review = ReviewEntity(
      productId: productId,
      productName: productName,
      productImage: productImage,
      rating: rating.value,
      reviewText: reviewText.value,
      imagePaths: [...imagePaths],
      createdAt: DateTime.now(),
    );

    // In a real app: send to backend. Here we just show success and return to Orders
    isSubmitting.value = false;
    Get.snackbar('Success', 'Thank you for your review.', snackPosition: SnackPosition.BOTTOM);
    // Return to previous route (Orders page)
    Get.back(result: review); // returns created review if needed
  }
}
