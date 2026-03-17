import 'package:farmacia_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:farmacia_app/pallete.dart';
import 'package:farmacia_app/splash_screen.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash',
    home: SplashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: const LoginScreen(),
    );
  }
}