import 'package:get/get.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/get_orders_usecase.dart';
import '../../../domain/usecases/get_order_detail_usecase.dart';
import '../../../domain/repositories/order_repository.dart';

class OrdersController extends GetxController {
  final GetOrdersUseCase getOrdersUseCase;
  final GetOrderDetailUseCase getOrderDetailUseCase;

  OrdersController({
    required this.getOrdersUseCase,
    required this.getOrderDetailUseCase,
  });

  final RxBool isLoading = false.obs;
  final RxList<OrderEntity> orders = <OrderEntity>[].obs;
  final RxString error = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      error.value = '';
      final list = await getOrdersUseCase();
      orders.assignAll(list);
    } catch (e) {
      error.value = 'Failed to load orders';
    } finally {
      isLoading.value = false;
    }
  }

  Future<OrderEntity?> getOrderDetail(String id) async {
    return await getOrderDetailUseCase(id);
  }

  // called when a review is submitted
  void setOrderReviewed(String orderId) {
    final idx = orders.indexWhere((o) => o.id == orderId);
    if (idx != -1) {
      final o = orders[idx];
      final updated = OrderEntity(
        id: o.id,
        status: o.status,
        placedAt: o.placedAt,
        deliveredAt: o.deliveredAt,
        subTotal: o.subTotal,
        deliveryFee: o.deliveryFee,
        total: o.total,
        items: o.items,
        address: o.address,
        reviewed: true,
      );
      orders[idx] = updated;
      orders.refresh();
    }
  }
}
