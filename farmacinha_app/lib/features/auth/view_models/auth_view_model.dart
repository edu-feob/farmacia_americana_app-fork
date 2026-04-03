import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isRememberMe = false;
  bool _obscurePassword = true;

  bool get isRememberMe => _isRememberMe;
  bool get obscurePassword => _obscurePassword;

  void toggleRememberMe(bool? value) {
    _isRememberMe = value ?? false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void login() {
    // Lógica de login futura
    debugPrint("Tentando login com: ${emailController.text}");
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
