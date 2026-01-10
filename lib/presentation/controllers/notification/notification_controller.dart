import 'package:get/get.dart';

class NotificationItem {
  final String title;
  final String message;
  final DateTime time;
  final bool isRead;

  NotificationItem({required this.title, required this.message, required this.time, this.isRead = false});

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(title: title, message: message, time: time, isRead: isRead ?? this.isRead);
  }
}

class NotificationController extends GetxController {
  RxList<NotificationItem> notifications = <NotificationItem>[
    NotificationItem(title: "Order Shipped", message: "Your order #123 has been shipped.", time: DateTime.now().subtract(const Duration(hours: 2))),
    NotificationItem(title: "Special Discount", message: "Get 25% off on your next grocery order!", time: DateTime.now().subtract(const Duration(hours: 5))),
    NotificationItem(title: "Payment Successful", message: "Your payment has been received.", time: DateTime.now().subtract(const Duration(days: 1)), isRead: true),
  ].obs;

  int get unreadCount => notifications.where((n) => n.isRead == false).length;

  void markAsRead(int index) {
    notifications[index] = notifications[index].copyWith(isRead: true);
    notifications.refresh();
  }

  void markAllAsRead() {
    notifications.value = notifications.map((e) => e.copyWith(isRead: true)).toList();
  }
}
