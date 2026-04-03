import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/core/widgets/login_field.dart';
import 'package:farmacia_app/core/widgets/social_button.dart';
import 'package:farmacia_app/core/widgets/password_field.dart'; // Widget que criamos antes
import 'package:farmacia_app/features/auth/view_models/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterViewModel viewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Criar conta',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Pallete.actionButton,
                      ),
                    ),
                    const SizedBox(height: 36),

                    const LoginField(
                      hintText: 'Nome completo',
                      // controller: viewModel.nameController,
                    ),
                    const SizedBox(height: 16),

                    const LoginField(
                      hintText: 'E-mail',
                      // controller: viewModel.emailController,
                    ),
                    const SizedBox(height: 16),

                    PasswordField(
                      controller: viewModel.passwordController,
                      obscureText: viewModel.obscurePassword,
                      onToggleVisibility: viewModel.togglePasswordVisibility,
                    ),
                    const SizedBox(height: 16),

                    PasswordField(
                      controller: viewModel.confirmPasswordController,
                      obscureText: viewModel.obscureConfirm,
                      onToggleVisibility: viewModel.toggleConfirmVisibility,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Checkbox(
                            side: const BorderSide(color: Pallete.borderColor),
                            value: viewModel.acceptedTerms,
                            activeColor: Pallete.actionButton,
                            onChanged: viewModel.setAcceptedTerms,
                          ),
                        ),
                        const SizedBox(width: 4),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 14, color: Pallete.textColor),
                            children: [
                              TextSpan(text: 'Concordo com os '),
                              TextSpan(
                                text: 'termos de uso',
                                style: TextStyle(
                                  color: Pallete.actionButton,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: viewModel.acceptedTerms ? viewModel.register : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.actionButton,
                          // ignore: deprecated_member_use
                          disabledBackgroundColor: Pallete.actionButton.withOpacity(0.4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'CRIAR CONTA',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    
                    // ... (resto dos botões sociais e versão)
                    const Text('ou'),
                    const SizedBox(height: 20),
                    SocialButton(
                      iconName: 'f_logo',
                      label: 'Entrar com Facebook',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}