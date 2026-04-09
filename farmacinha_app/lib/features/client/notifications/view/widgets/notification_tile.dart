import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/client/notifications/data/models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:
              notification.isRead
                  ? Pallete.whiteColor
                  : Pallete.primaryRed.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color:
                notification.isRead
                    ? Pallete.borderColor
                    : Pallete.primaryRed.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _typeColor(notification.type).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _typeIcon(notification.type),
                color: _typeColor(notification.type),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight:
                                notification.isRead
                                    ? FontWeight.w600
                                    : FontWeight.bold,
                            fontSize: 13,
                            color: const Color(0xFF291715),
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Pallete.primaryRed,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Pallete.textColor,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatDate(notification.createdAt),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Pallete.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _typeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.local_shipping_rounded;
      case NotificationType.promotion:
        return Icons.local_offer_rounded;
      case NotificationType.prescription:
        return Icons.description_rounded;
      case NotificationType.loyalty:
        return Icons.star_rounded;
      case NotificationType.product:
        return Icons.medication_rounded;
    }
  }

  Color _typeColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Pallete.primaryRed;
      case NotificationType.promotion:
        return Pallete.accentYellow;
      case NotificationType.prescription:
        return Colors.blue;
      case NotificationType.loyalty:
        return Colors.orange;
      case NotificationType.product:
        return Colors.green;
    }
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return 'Há ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Há ${diff.inHours}h';
    if (diff.inDays == 1) return 'Ontem';
    return 'Há ${diff.inDays} dias';
  }
}
