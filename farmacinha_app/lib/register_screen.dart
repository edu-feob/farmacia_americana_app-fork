import 'package:flutter/material.dart';
import 'package:farmacia_app/pallete.dart';
import 'package:farmacia_app/widgets/login_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptedTerms = false;

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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

                const LoginField(hintText: 'Nome completo'),
                const SizedBox(height: 16),

                const LoginField(hintText: 'E-mail'),
                const SizedBox(height: 16),

                _PasswordField(
                  hintText: 'Senha',
                  obscureText: _obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                const SizedBox(height: 16),

                _PasswordField(
                  hintText: 'Confirmar senha',
                  obscureText: _obscureConfirm,
                  onToggle: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Checkbox(
                        side: const BorderSide(color: Pallete.borderColor),
                        value: _acceptedTerms,
                        activeColor: Pallete.actionButton,
                        onChanged: (value) =>
                            setState(() => _acceptedTerms = value!),
                      ),
                    ),
                    const SizedBox(width: 4),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Pallete.textColor,
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.hintText,
    required this.obscureText,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(color: Color(0xFF1A1A1A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Pallete.textColor, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Pallete.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Pallete.actionButton, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Pallete.textColor,
            size: 20,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
