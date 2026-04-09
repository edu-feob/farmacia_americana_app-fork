import 'package:farmacia_app/features/client/orders/data/models/order_model.dart';

class MockOrders {
  static List<Order> getOrders() {
    return [
      Order(
        id: 'PED-2024-001',
        userId: '1',
        status: OrderStatus.transit,
        paymentMethod: PaymentMethod.pix,
        totalAmount: 89.40,
        deliveryAddress: 'Rua das Flores, 123 - São Paulo, SP',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        estimatedDelivery: DateTime.now().add(const Duration(hours: 2)),
        trackingCode: 'BR123456789',
        items: const [
          OrderItem(
            productId: '1',
            productName: 'Dipirona 500mg',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 2,
            unitPrice: 15.90,
          ),
          OrderItem(
            productId: '2',
            productName: 'Vitamina C 1000mg',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 1,
            unitPrice: 45.00,
          ),
          OrderItem(
            productId: '5',
            productName: 'Sabonete Líquido 250ml',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 1,
            unitPrice: 8.90,
          ),
        ],
      ),
      Order(
        id: 'PED-2024-002',
        userId: '1',
        status: OrderStatus.preparing,
        paymentMethod: PaymentMethod.cardOnDelivery,
        totalAmount: 134.80,
        deliveryAddress: 'Rua das Flores, 123 - São Paulo, SP',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        estimatedDelivery: DateTime.now().add(const Duration(hours: 4)),
        trackingCode: 'BR987654321',
        items: const [
          OrderItem(
            productId: '8',
            productName: 'Hidratante Facial 50ml',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 1,
            unitPrice: 59.90,
          ),
          OrderItem(
            productId: '10',
            productName: 'Protetor Solar FPS 50',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 1,
            unitPrice: 45.00,
          ),
          OrderItem(
            productId: '7',
            productName: 'Colgate Total 90g',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 2,
            unitPrice: 7.50,
          ),
        ],
      ),
      Order(
        id: 'PED-2024-003',
        userId: '1',
        status: OrderStatus.delivered,
        paymentMethod: PaymentMethod.pix,
        totalAmount: 55.00,
        deliveryAddress: 'Rua das Flores, 123 - São Paulo, SP',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        estimatedDelivery:
            DateTime.now().subtract(const Duration(days: 3, hours: -2)),
        trackingCode: 'BR112233445',
        items: const [
          OrderItem(
            productId: '12',
            productName: 'Ômega 3 60 cápsulas',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 1,
            unitPrice: 55.00,
          ),
        ],
      ),
      Order(
        id: 'PED-2024-004',
        userId: '1',
        status: OrderStatus.delivered,
        paymentMethod: PaymentMethod.cashOnDelivery,
        totalAmount: 28.50,
        deliveryAddress: 'Rua das Flores, 123 - São Paulo, SP',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        items: const [
          OrderItem(
            productId: '3',
            productName: 'Omeprazol 20mg',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 1,
            unitPrice: 28.50,
          ),
        ],
      ),
      Order(
        id: 'PED-2024-005',
        userId: '1',
        status: OrderStatus.cancelled,
        paymentMethod: PaymentMethod.pix,
        totalAmount: 78.90,
        deliveryAddress: 'Rua das Flores, 123 - São Paulo, SP',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        items: const [
          OrderItem(
            productId: '11',
            productName: 'Colágeno Hidrolisado',
            productImageUrl:
                'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
            quantity: 1,
            unitPrice: 78.90,
          ),
        ],
      ),
    ];
  }
}
