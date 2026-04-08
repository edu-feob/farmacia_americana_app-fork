import 'package:farmacia_app/features/client/orders/data/models/order_model.dart';
import 'package:farmacia_app/features/client/orders/data/mocks/mock_orders.dart';

class MockPurchaseHistory {
  /// Retorna apenas os pedidos já entregues (histórico de compras finalizadas)
  static List<Order> getHistory() {
    return MockOrders.getOrders()
        .where((o) => o.status == OrderStatus.delivered)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
