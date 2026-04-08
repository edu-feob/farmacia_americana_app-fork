import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/orders/data/models/order_model.dart';
import 'package:farmacia_app/features/client/purchase_history/data/mocks/mock_purchase_history.dart';

class PurchaseHistoryViewModel extends ChangeNotifier {
  List<Order> _history = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Order> get history => _history;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get totalSpent =>
      _history.fold(0, (sum, o) => sum + o.totalAmount);

  int get totalOrders => _history.length;

  PurchaseHistoryViewModel() {
    _load();
  }

  void _load() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      try {
        _history = MockPurchaseHistory.getHistory();
        _isLoading = false;
        notifyListeners();
      } catch (e) {
        _errorMessage = 'Erro ao carregar histórico.';
        _isLoading = false;
        notifyListeners();
      }
    });
  }
}
