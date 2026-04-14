import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view_model/attendant_profile_data_store.dart';

class AttendantPersonalDataScreen extends StatefulWidget {
  const AttendantPersonalDataScreen({super.key});

  @override
  State<AttendantPersonalDataScreen> createState() => _AttendantPersonalDataScreenState();
}

class _AttendantPersonalDataScreenState extends State<AttendantPersonalDataScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _cpfController;
  late final TextEditingController _phoneController;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _cpfFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  bool _isNamePrefilled = true;
  bool _isEmailPrefilled = true;
  bool _isCpfPrefilled = true;
  bool _isPhonePrefilled = true;

  @override
  void initState() {
    super.initState();
    final profile = AttendantProfileDataStore.instance.data;

    _nameController = TextEditingController(text: profile.fullName);
    _emailController = TextEditingController(text: profile.email);
    _cpfController = TextEditingController(text: profile.cpf);
    _phoneController = TextEditingController(text: profile.phone);

    _nameFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _nameFocusNode,
        controller: _nameController,
        isPrefilled: _isNamePrefilled,
        onChanged: (value) => _isNamePrefilled = value,
      ),
    );
    _emailFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _emailFocusNode,
        controller: _emailController,
        isPrefilled: _isEmailPrefilled,
        onChanged: (value) => _isEmailPrefilled = value,
      ),
    );
    _cpfFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _cpfFocusNode,
        controller: _cpfController,
        isPrefilled: _isCpfPrefilled,
        onChanged: (value) => _isCpfPrefilled = value,
      ),
    );
    _phoneFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _phoneFocusNode,
        controller: _phoneController,
        isPrefilled: _isPhonePrefilled,
        onChanged: (value) => _isPhonePrefilled = value,
      ),
    );
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _cpfFocusNode.dispose();
    _phoneFocusNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Pallete.primaryRed),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Dados Pessoais',
          style: TextStyle(
            color: Pallete.primaryRed,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputLabel('NOME COMPLETO'),
            _buildTextField(
              controller: _nameController,
              hint: 'Digite seu nome completo',
              icon: Icons.person,
              focusNode: _nameFocusNode,
              isPrefilled: _isNamePrefilled,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 20),
            _buildInputLabel('E-MAIL'),
            _buildTextField(
              controller: _emailController,
              hint: 'seu@email.com',
              icon: Icons.mail,
              focusNode: _emailFocusNode,
              isPrefilled: _isEmailPrefilled,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildInputLabel('CPF'),
            _buildTextField(
              controller: _cpfController,
              hint: '000.000.000-00',
              icon: Icons.badge,
              focusNode: _cpfFocusNode,
              isPrefilled: _isCpfPrefilled,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
            ),
            const SizedBox(height: 20),
            _buildInputLabel('TELEFONE'),
            _buildTextField(
              controller: _phoneController,
              hint: '(00) 00000-0000',
              icon: Icons.call,
              focusNode: _phoneFocusNode,
              isPrefilled: _isPhonePrefilled,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, PhoneInputFormatter()],
            ),
            const SizedBox(height: 28),
            _buildSecurityCard(),
            const SizedBox(height: 32),
            _buildSaveButton(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Pallete.primaryRed,
        unselectedItemColor: const Color(0xFF9F9F9F),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'INÍCIO'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'BUSCAR'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'CHAT'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL'),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 10),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
          color: Color(0xFF4D302D),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required FocusNode focusNode,
    required bool isPrefilled,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDEDEC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        autocorrect: true,
        enableSuggestions: true,
        style: TextStyle(
          fontSize: 16,
          color: isPrefilled ? const Color(0xFF9B8D8B) : const Color(0xFF1C1617),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 21,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(icon, color: const Color(0xFFBBA9A7), size: 24),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        ),
      ),
    );
  }

  void _clearPrefilledOnFocus({
    required FocusNode focusNode,
    required TextEditingController controller,
    required bool isPrefilled,
    required ValueChanged<bool> onChanged,
  }) {
    if (!focusNode.hasFocus || !isPrefilled) return;
    setState(() {
      controller.clear();
      onChanged(false);
    });
  }

  Widget _buildSecurityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFCCE4F4),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.verified_user_rounded,
                  color: Color(0xFF005F93),
                  size: 34,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Segurança da Conta',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color(0xFF1E1615),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Última alteração há 3 meses',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5D3F3C),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: _showChangePasswordSheet,
            child: const Text(
              'Alterar Senha',
              style: TextStyle(
                color: Pallete.primaryRed,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          colors: [Pallete.primaryRed, Color(0xFFE31B23)],
        ),
        boxShadow: [
          BoxShadow(
            color: Pallete.primaryRed.withOpacity(0.30),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _savePersonalData,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          'Salvar Alterações',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _savePersonalData() {
    AttendantProfileDataStore.instance.updatePersonalData(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      cpf: _cpfController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    _showInfo('Dados salvos com sucesso!');
    Navigator.of(context).pop();
  }

  void _onBottomNavTap(int index) {
    if (index == 3) {
      Navigator.pushReplacementNamed(context, AppRoutes.attendantProfile);
      return;
    }

    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeAttendant);
      return;
    }

    if (index == 1) {
      Navigator.pushReplacementNamed(context, AppRoutes.attendantSearch);
      return;
    }

    _showInfo('Tela de chat ainda não disponível.');
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showChangePasswordSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ChangePasswordSheet(
        onMessage: _showGlobalMessage,
      ),
    );
  }

  void _showGlobalMessage(String message) {
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Pallete.primaryRed),
            ),
          ),
        ],
      ),
    );
  }
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 11 ? digits.substring(0, 11) : digits;
    final buffer = StringBuffer();

    for (int i = 0; i < limited.length; i++) {
      if (i == 3 || i == 6) buffer.write('.');
      if (i == 9) buffer.write('-');
      buffer.write(limited[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 11 ? digits.substring(0, 11) : digits;
    final buffer = StringBuffer();

    for (int i = 0; i < limited.length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 2) buffer.write(') ');
      if (i == 7) buffer.write('-');
      buffer.write(limited[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ChangePasswordSheet extends StatefulWidget {
  final ValueChanged<String> onMessage;

  const _ChangePasswordSheet({
    required this.onMessage,
  });

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _hideCurrent = true;
  bool _hideNew = true;
  bool _hideConfirm = true;

  bool get _hasMinLength => _newPasswordController.text.length >= 6;
  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_newPasswordController.text);
  bool get _hasLowercase => RegExp(r'[a-z]').hasMatch(_newPasswordController.text);
  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_newPasswordController.text);

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alterar Senha',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1615),
              ),
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              controller: _currentPasswordController,
              label: 'Senha atual',
              obscureText: _hideCurrent,
              onToggleVisibility: () => setState(() => _hideCurrent = !_hideCurrent),
            ),
            const SizedBox(height: 12),
            _buildPasswordField(
              controller: _newPasswordController,
              label: 'Nova senha',
              obscureText: _hideNew,
              onToggleVisibility: () => setState(() => _hideNew = !_hideNew),
            ),
            const SizedBox(height: 12),
            _buildPasswordField(
              controller: _confirmPasswordController,
              label: 'Confirmar nova senha',
              obscureText: _hideConfirm,
              onToggleVisibility: () => setState(() => _hideConfirm = !_hideConfirm),
            ),
            const SizedBox(height: 14),
            _buildRequirement('Mínimo de 6 caracteres', _hasMinLength),
            _buildRequirement('1 letra maiúscula', _hasUppercase),
            _buildRequirement('1 letra minúscula', _hasLowercase),
            _buildRequirement('1 caractere numérico', _hasNumber),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveNewPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.primaryRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Salvar nova senha'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool met) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: met ? Colors.green : Pallete.primaryRed,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: met ? Colors.green : Pallete.primaryRed,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  void _saveNewPassword() {
    final hasAllRules = _hasMinLength && _hasUppercase && _hasLowercase && _hasNumber;
    if (_currentPasswordController.text.isEmpty) {
      widget.onMessage('Informe a senha atual.');
      return;
    }
    if (!hasAllRules) {
      widget.onMessage('A nova senha não atende aos requisitos.');
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      widget.onMessage('A confirmação da senha não confere.');
      return;
    }

    Navigator.of(context).pop();
    widget.onMessage('Senha alterada com sucesso!');
  }
}