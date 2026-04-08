import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/orders/data/models/order_model.dart';
import 'package:farmacia_app/features/client/orders/data/mocks/mock_orders.dart';

class OrdersViewModel extends ChangeNotifier {
  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedFilterIndex = 0; // 0=Todos, 1=Ativos, 2=Entregues, 3=Cancelados

  List<Order> get filteredOrders => _filteredOrders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedFilterIndex => _selectedFilterIndex;

  final List<String> filterLabels = [
    'Todos',
    'Ativos',
    'Entregues',
    'Cancelados',
  ];

  OrdersViewModel() {
    _loadOrders();
  }

  void _loadOrders() {
    _setLoading(true);
    Future.delayed(const Duration(milliseconds: 600), () {
      try {
        _allOrders = MockOrders.getOrders();
        _allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        _applyFilter();
        _setLoading(false);
      } catch (e) {
        _errorMessage = 'Erro ao carregar pedidos.';
        _setLoading(false);
      }
    });
  }

  void selectFilter(int index) {
    _selectedFilterIndex = index;
    _applyFilter();
  }

  void _applyFilter() {
    switch (_selectedFilterIndex) {
      case 1:
        _filteredOrders =
            _allOrders.where((o) => o.status.isActive).toList();
        break;
      case 2:
        _filteredOrders =
            _allOrders
                .where((o) => o.status == OrderStatus.delivered)
                .toList();
        break;
      case 3:
        _filteredOrders =
            _allOrders
                .where((o) => o.status == OrderStatus.cancelled)
                .toList();
        break;
      default:
        _filteredOrders = List.from(_allOrders);
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
