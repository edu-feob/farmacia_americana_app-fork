enum NotificationType { order, promotion, prescription, loyalty, product }

extension NotificationTypeExtension on NotificationType {
  String get label {
    switch (this) {
      case NotificationType.order:
        return 'Pedido';
      case NotificationType.promotion:
        return 'Promoção';
      case NotificationType.prescription:
        return 'Receita';
      case NotificationType.loyalty:
        return 'Fidelidade';
      case NotificationType.product:
        return 'Produto';
    }
  }
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime createdAt;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });
}
