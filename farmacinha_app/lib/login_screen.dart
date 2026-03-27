import 'package:flutter/material.dart';
import 'package:farmacia_app/widgets/gradient_button.dart';
import 'package:farmacia_app/widgets/social.button.dart';
import 'package:farmacia_app/widgets/login_field.dart';
import 'package:farmacia_app/pallete.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false; // Estado para a caixinha de Salvar Login
  bool _obscurePassword = true; // Estado do icone de ocultar senha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 140),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 233, 206, 120),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),

              // Email e Senha
              const LoginField(hintText: 'Email'),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 330),
                child: TextFormField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Pallete.borderColor,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Pallete.actionButton,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Pallete.textColor,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
              ),

              // Caixinha "Salvar Login"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 36,
                      child: Checkbox(
                        side: const BorderSide(color: Pallete.borderColor),
                        value: isRememberMe,
                        activeColor: const Color.fromARGB(255, 233, 206, 120),
                        onChanged: (value) {
                          setState(() {
                            isRememberMe = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Text(
                      'Salvar Login',
                      style: TextStyle(fontSize: 14, color: Pallete.textColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              const GradientButton(),

              const SizedBox(height: 52),
              const Text(
                'ou',
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(126, 36, 36, 36),
                ),
              ),
              const SizedBox(height: 20),

              // Opções Sociais
              SocialButton(
                iconName: 'g_logo',
                label: 'Entrar com Google',
                iconColor: Pallete.googleLogo,
                textColor: Pallete.textColor,
                horizontalPadding: 80.0,
                onPressed: () {},
              ),
              const SizedBox(height: 25),
              SocialButton(
                iconName: 'f_logo',
                iconColor: Pallete.facebookLogo,
                label: 'Entrar com Facebook',
                textColor: Pallete.textColor,
                onPressed: () {},
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
