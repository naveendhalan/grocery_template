import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/address_entity.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../widgets/profile/address_card.dart';

class AddressPage extends GetView<ProfileController> {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Manage Addresses',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: theme.colorScheme.primary),
            onPressed: () => _showAddEditAddressDialog(context, null),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.addresses.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_off, size: 64, color: theme.colorScheme.onSurface.withOpacity(0.3)),
                      const SizedBox(height: 16),
                      Text('No addresses added yet', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => _showAddEditAddressDialog(context, null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Add Address'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.addresses.length,
                  itemBuilder: (context, index) {
                    final address = controller.addresses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AddressCard(address: address, onEdit: () => _showAddEditAddressDialog(context, address), onDelete: () => _showDeleteDialog(context, address)),
                    );
                  },
                ),
        ),
      ),
    );
  }

  void _showAddEditAddressDialog(BuildContext context, AddressEntity? address) {
    final theme = Theme.of(context);
    final isEdit = address != null;

    final titleController = TextEditingController(text: address?.title ?? '');
    final addressLine1Controller = TextEditingController(text: address?.addressLine1 ?? '');
    final addressLine2Controller = TextEditingController(text: address?.addressLine2 ?? '');
    final cityController = TextEditingController(text: address?.city ?? '');
    final stateController = TextEditingController(text: address?.state ?? '');
    final pincodeController = TextEditingController(text: address?.pincode ?? '');
    final phoneController = TextEditingController(text: address?.phone ?? '');
    final isDefault = (address?.isDefault ?? false).obs;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isEdit ? 'Edit Address' : 'Add Address',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title (e.g., Home, Office)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: addressLine1Controller,
                  decoration: InputDecoration(
                    labelText: 'Address Line 1',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: addressLine2Controller,
                  decoration: InputDecoration(
                    labelText: 'Address Line 2',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cityController,
                        decoration: InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: stateController,
                        decoration: InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: pincodeController,
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CheckboxListTile(
                    title: const Text('Set as default address'),
                    value: isDefault.value,
                    onChanged: (value) => isDefault.value = value ?? false,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty &&
                              addressLine1Controller.text.isNotEmpty &&
                              cityController.text.isNotEmpty &&
                              stateController.text.isNotEmpty &&
                              pincodeController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            final newAddress = AddressEntity(
                              id: address?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                              title: titleController.text,
                              addressLine1: addressLine1Controller.text,
                              addressLine2: addressLine2Controller.text,
                              city: cityController.text,
                              state: stateController.text,
                              pincode: pincodeController.text,
                              phone: phoneController.text,
                              isDefault: isDefault.value,
                            );

                            if (isEdit) {
                              controller.editAddress(address.id, newAddress);
                            } else {
                              controller.addAddress(newAddress);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(isEdit ? 'Update' : 'Add'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, AddressEntity address) {
    final theme = Theme.of(context);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Delete Address',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
              ),
              const SizedBox(height: 16),
              Text('Are you sure you want to delete "${address.title}" address?', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.deleteAddress(address.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: theme.colorScheme.onError,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
