import 'package:flutter/material.dart';
import 'package:farmacia_app/features/splash/splash_screen.dart';
import 'package:farmacia_app/features/auth/views/welcome_screen.dart';
import 'package:farmacia_app/features/auth/views/login_screen.dart';
import 'package:farmacia_app/features/auth/views/register_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        welcome: (_) => WelcomeScreen(),
        login: (_) => const LoginScreen(),
        register: (_) => const RegisterScreen(),
      };
}