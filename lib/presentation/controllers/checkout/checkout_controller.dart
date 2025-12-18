import 'package:get/get.dart';
import '../../../domain/entities/address_entity.dart';
import '../../controllers/cart/cart_controller.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../../config/routes/app_routes.dart';

enum PaymentMethod { cash, card, upi }

class CheckoutController extends GetxController {
  final CartController cartController = Get.find<CartController>();
  final ProfileController profileController = Get.find<ProfileController>();

  final Rx<AddressEntity?> selectedAddress = Rx<AddressEntity?>(null);
  final Rx<PaymentMethod> selectedPaymentMethod = PaymentMethod.cash.obs;
  final RxString orderId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDefaultAddress();
  }

  void _loadDefaultAddress() {
    if (profileController.addresses.isNotEmpty) {
      final defaultAddress = profileController.addresses.firstWhere(
        (addr) => addr.isDefault,
        orElse: () => profileController.addresses.first,
      );
      selectedAddress.value = defaultAddress;
    }
  }

  void selectAddress(AddressEntity address) {
    selectedAddress.value = address;
  }

  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod.value = method;
  }

  double get subtotal => cartController.subtotal;
  double get deliveryFee => cartController.deliveryFee;
  double get total => cartController.total;

  bool get canPlaceOrder {
    return selectedAddress.value != null && cartController.cartItems.isNotEmpty;
  }

  void placeOrder() {
    if (!canPlaceOrder) return;

    // Generate order ID
    orderId.value = 'ORD${DateTime.now().millisecondsSinceEpoch}';

    // Clear cart
    cartController.clearCart();

    // Navigate to order confirmation
    Get.offNamed(
      AppRoutes.orderConfirmation,
      arguments: {
        'orderId': orderId.value,
        'address': selectedAddress.value,
        'paymentMethod': selectedPaymentMethod.value,
        'total': total,
      },
    );
  }
}
