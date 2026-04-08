import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/orders/data/models/order_model.dart';
import 'package:farmacia_app/features/client/delivery/view/widgets/tracking_timeline.dart';

class DeliveryViewModel extends ChangeNotifier {
  final Order order;
  bool _isLoading = false;

  DeliveryViewModel({required this.order}) {
    _loadTracking();
  }

  bool get isLoading => _isLoading;

  List<TrackingEvent> get trackingEvents {
    final now = DateTime.now();
    return [
      TrackingEvent(
        title: 'Saiu para entrega',
        description: 'O entregador está a caminho do seu endereço.',
        timestamp: now.subtract(const Duration(minutes: 30)),
      ),
      TrackingEvent(
        title: 'Pedido enviado',
        description: 'Seu pedido saiu da farmácia.',
        timestamp: now.subtract(const Duration(hours: 1)),
      ),
      TrackingEvent(
        title: 'Em preparo',
        description: 'A farmácia está separando seus produtos.',
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      TrackingEvent(
        title: 'Pedido confirmado',
        description: 'Seu pedido foi aceito pela farmácia.',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 30)),
      ),
      TrackingEvent(
        title: 'Pedido realizado',
        description: 'Seu pedido foi registrado com sucesso.',
        timestamp: order.createdAt,
      ),
    ];
  }

  String get estimatedTime {
    if (order.estimatedDelivery == null) return 'Em breve';
    final diff = order.estimatedDelivery!.difference(DateTime.now());
    if (diff.inMinutes <= 0) return 'Chegando agora';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    return '${diff.inHours}h ${diff.inMinutes % 60}min';
  }

  void _loadTracking() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      _isLoading = false;
      notifyListeners();
    });
  }
}
