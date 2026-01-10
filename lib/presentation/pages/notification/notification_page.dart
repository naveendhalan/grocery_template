import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/controllers/notification/notification_controller.dart';
import '../../widgets/notification/notification_card.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          TextButton(
            onPressed: controller.markAllAsRead,
            child: Text("Mark All Read", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(child: Text("No notifications", style: theme.textTheme.titleMedium));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final n = controller.notifications[index];
            return NotificationCard(item: n, onTap: () => controller.markAsRead(index));
          },
        );
      }),
    );
  }
}
