import '../../../domain/entities/order_entity.dart';
import '../../../domain/repositories/order_repository.dart';
import '../datasources/order_local_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;

  // in-memory cache for demo
  List<OrderModel> _cache = [];

  OrderRepositoryImpl(this.localDataSource);

  @override
  Future<List<OrderEntity>> getOrders() async {
    _cache = await localDataSource.getOrders();
    return _cache;
  }

  @override
  Future<OrderEntity?> getOrderById(String id) async {
    if (_cache.isEmpty) {
      await getOrders();
    }
    try {
      return _cache.firstWhere((o) => o.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> markOrderReviewed(String orderId) async {
    final idx = _cache.indexWhere((o) => o.id == orderId);
    if (idx != -1) {
      final m = _cache[idx];
      _cache[idx] = OrderModel(
        id: m.id,
        status: m.status,
        placedAt: m.placedAt,
        deliveredAt: m.deliveredAt,
        subTotal: m.subTotal,
        deliveryFee: m.deliveryFee,
        total: m.total,
        items: m.items.cast<OrderItemModel>(),
        address: m.address,
        reviewed: true,
      );
    }
  }
}
