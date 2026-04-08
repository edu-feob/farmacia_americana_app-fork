import 'package:flutter/material.dart';
import 'package:farmacia_app/features/auth/data/models/user_model.dart';
import 'package:farmacia_app/features/auth/data/mocks/mock_users.dart';

class AccountViewModel extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  // Pontos de fidelidade (mock)
  int get loyaltyPoints => 450;
  String get loyaltyTier => 'Cliente Gold';

  AccountViewModel() {
    _loadUser();
  }

  void _loadUser() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      // Carrega o primeiro usuário cliente do mock
      _currentUser = MockUsers.getUsers().firstWhere(
        (u) => u.role == UserRole.cliente,
      );
      _isLoading = false;
      notifyListeners();
    });
  }

  void logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
}
