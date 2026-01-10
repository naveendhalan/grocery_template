import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/review/review_controller.dart';
import '../../widgets/review/image_picker_widget.dart';
import '../../widgets/review/review_text_field.dart';
import '../../widgets/review/star_rating.dart';

class ReviewFlowPage extends GetView<ReviewController> {
  const ReviewFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textController = TextEditingController(text: controller.reviewText.value);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final s = controller.step.value;
          return Text('Write a Review - Step $s/4');
        }),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final step = controller.step.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product header
              Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      image: controller.productImage.isNotEmpty ? DecorationImage(image: NetworkImage(controller.productImage), fit: BoxFit.cover) : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(controller.productName, style: theme.textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: 20),

              // Step content
              if (step == 1) ...[
                Text('Rate the product', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                StarRating(value: controller.rating.value, onChanged: (v) => controller.setRating(v)),
              ] else if (step == 2) ...[
                Text('Write your review', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                ReviewTextField(controller: textController, onChanged: (t) => controller.setReviewText(t)),
              ] else if (step == 3) ...[
                Text('Add photos (optional)', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                ImagePickerWidget(images: controller.imagePaths.toList(), onPickFromGallery: controller.addImageFromGallery, onPickFromCamera: controller.addImageFromCamera, onRemove: (i) => controller.removeImageAt(i)),
              ] else if (step == 4) ...[
                Text('Preview & Submit', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                Text('Rating: ${controller.rating.value}', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 8),
                Text('Review: ${controller.reviewText.value}', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: controller.imagePaths.map((p) => SizedBox(width: 80, height: 80, child: Image.asset(p, fit: BoxFit.cover))).toList(),
                ),
              ],

              const Spacer(),

              // Navigation buttons
              Row(
                children: [
                  if (!controller.isFirstStep)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.surface, foregroundColor: theme.colorScheme.onSurface, elevation: 0),
                        onPressed: controller.prevStep,
                        child: const Text('Back'),
                      ),
                    ),
                  if (!controller.isFirstStep) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Obx(() {
                      if (controller.isSubmitting.value) {
                        return ElevatedButton.icon(
                          onPressed: null,
                          icon: const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                          label: const Text('Submitting...'),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (controller.isLastStep) {
                            controller.submitReview();
                          } else {
                            // if leaving step 2 ensure textController updates controller
                            controller.setReviewText(textController.text);
                            controller.nextStep();
                          }
                        },
                        child: Text(controller.isLastStep ? 'Submit' : 'Next'),
                      );
                    }),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
