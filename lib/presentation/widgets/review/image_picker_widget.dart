import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final List<String> images;
  final VoidCallback onPickFromGallery;
  final VoidCallback onPickFromCamera;
  final ValueChanged<int> onRemove;

  const ImagePickerWidget({super.key, required this.images, required this.onPickFromGallery, required this.onPickFromCamera, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...List.generate(images.length, (i) {
              return Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: FileImage(File(images[i])), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: -6,
                    right: -6,
                    child: GestureDetector(
                      onTap: () => onRemove(i),
                      child: Container(
                        decoration: BoxDecoration(color: theme.colorScheme.surface, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 18),
                      ),
                    ),
                  ),
                ],
              );
            }),

            // Add Button
            GestureDetector(
              onTap: () => _openSourceMenu(context),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
                ),
                child: Icon(Icons.add_a_photo, color: theme.colorScheme.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _openSourceMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                onPickFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                onPickFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }
}
