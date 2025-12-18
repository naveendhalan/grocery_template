import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../config/routes/app_routes.dart';

class ProfileController extends GetxController {
  final RxString name = 'John Doe'.obs;
  final RxString email = 'john.doe@example.com'.obs;
  final RxString phone = '+1 234 567 8900'.obs;
  final RxString profileImage = ''.obs;

  final RxList<AddressEntity> addresses = <AddressEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDemoData();
  }

  void _loadDemoData() {
    addresses.assignAll([
      AddressEntity(
        id: '1',
        title: 'Home',
        addressLine1: '123 Main Street',
        addressLine2: 'Apartment 4B',
        city: 'New York',
        state: 'NY',
        pincode: '10001',
        phone: '+1 234 567 8900',
        isDefault: true,
      ),
      AddressEntity(
        id: '2',
        title: 'Office',
        addressLine1: '456 Business Ave',
        addressLine2: 'Suite 200',
        city: 'New York',
        state: 'NY',
        pincode: '10002',
        phone: '+1 234 567 8901',
        isDefault: false,
      ),
    ]);
  }

  void updateProfile({
    required String newName,
    required String newEmail,
    required String newPhone,
  }) {
    name.value = newName;
    email.value = newEmail;
    phone.value = newPhone;
    Get.back();
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primaryContainer,
      colorText: Get.theme.colorScheme.onPrimaryContainer,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void addAddress(AddressEntity address) {
    if (address.isDefault) {
      for (var addr in addresses) {
        if (addr.isDefault) {
          addresses[addresses.indexOf(addr)] = AddressEntity(
            id: addr.id,
            title: addr.title,
            addressLine1: addr.addressLine1,
            addressLine2: addr.addressLine2,
            city: addr.city,
            state: addr.state,
            pincode: addr.pincode,
            phone: addr.phone,
            isDefault: false,
          );
        }
      }
    }
    addresses.add(address);
    Get.back();
    Get.snackbar(
      'Success',
      'Address added successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primaryContainer,
      colorText: Get.theme.colorScheme.onPrimaryContainer,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void editAddress(String id, AddressEntity updatedAddress) {
    final index = addresses.indexWhere((addr) => addr.id == id);
    if (index != -1) {
      if (updatedAddress.isDefault) {
        for (var addr in addresses) {
          if (addr.isDefault && addr.id != id) {
            final defaultIndex = addresses.indexOf(addr);
            addresses[defaultIndex] = AddressEntity(
              id: addr.id,
              title: addr.title,
              addressLine1: addr.addressLine1,
              addressLine2: addr.addressLine2,
              city: addr.city,
              state: addr.state,
              pincode: addr.pincode,
              phone: addr.phone,
              isDefault: false,
            );
          }
        }
      }
      addresses[index] = updatedAddress;
      Get.back();
      Get.snackbar(
        'Success',
        'Address updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void deleteAddress(String id) {
    addresses.removeWhere((addr) => addr.id == id);
    Get.snackbar(
      'Success',
      'Address deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primaryContainer,
      colorText: Get.theme.colorScheme.onPrimaryContainer,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void logout() {
    Get.offAllNamed(AppRoutes.login);
  }
}
