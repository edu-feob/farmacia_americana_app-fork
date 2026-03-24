import 'package:flutter/material.dart';
import 'package:farmacia_app/splash_screen.dart';
import 'package:farmacia_app/welcome_screen.dart';
import 'package:farmacia_app/login_screen.dart';
import 'package:farmacia_app/register_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        welcome: (_) => const WelcomeScreen(),
        login: (_) => const LoginScreen(),
        register: (_) => const RegisterScreen(),
      };
}