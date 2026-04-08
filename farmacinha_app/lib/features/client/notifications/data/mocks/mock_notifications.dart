import 'package:farmacia_app/features/client/notifications/data/models/notification_model.dart';

class MockNotifications {
  static List<AppNotification> getNotifications() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: 'n1',
        title: 'Pedido saiu para entrega! 🚚',
        body:
            'Seu pedido PED-2024-001 está a caminho. Previsão de chegada em 2 horas.',
        type: NotificationType.order,
        createdAt: now.subtract(const Duration(minutes: 15)),
        isRead: false,
      ),
      AppNotification(
        id: 'n2',
        title: 'Promoção especial hoje! 🎉',
        body:
            'Até 30% de desconto em produtos de beleza e higiene. Aproveite!',
        type: NotificationType.promotion,
        createdAt: now.subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      AppNotification(
        id: 'n3',
        title: 'Pedido confirmado ✅',
        body:
            'Seu pedido PED-2024-002 foi confirmado e está sendo preparado.',
        type: NotificationType.order,
        createdAt: now.subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      AppNotification(
        id: 'n4',
        title: 'Receita aprovada 📋',
        body:
            'Sua receita médica foi analisada e aprovada pelo farmacêutico.',
        type: NotificationType.prescription,
        createdAt: now.subtract(const Duration(days: 1)),
        isRead: true,
      ),
      AppNotification(
        id: 'n5',
        title: 'Pontos adicionados! ⭐',
        body:
            'Você ganhou 50 pontos com sua última compra. Total: 450 pontos.',
        type: NotificationType.loyalty,
        createdAt: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
      AppNotification(
        id: 'n6',
        title: 'Produto disponível 💊',
        body:
            'O produto "Vitamina D 2000UI" que você buscou está disponível novamente.',
        type: NotificationType.product,
        createdAt: now.subtract(const Duration(days: 5)),
        isRead: true,
      ),
    ];
  }
}
