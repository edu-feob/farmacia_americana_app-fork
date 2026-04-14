import 'package:flutter/material.dart';

class AttendantProfileData {
  final String fullName;
  final String email;
  final String cpf;
  final String phone;
  final String roleDescription;

  const AttendantProfileData({
    required this.fullName,
    required this.email,
    required this.cpf,
    required this.phone,
    required this.roleDescription,
  });

  AttendantProfileData copyWith({
    String? fullName,
    String? email,
    String? cpf,
    String? phone,
    String? roleDescription,
  }) {
    return AttendantProfileData(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      phone: phone ?? this.phone,
      roleDescription: roleDescription ?? this.roleDescription,
    );
  }
}

class AttendantProfileDataStore extends ChangeNotifier {
  AttendantProfileDataStore._();

  static final AttendantProfileDataStore instance = AttendantProfileDataStore._();

  AttendantProfileData _data = const AttendantProfileData(
    fullName: 'Carlos Alberto',
    email: 'carlos.alberto@farmaciaamericana.com',
    cpf: '123.456.789-00',
    phone: '(11) 98765-4321',
    roleDescription: 'Farmacêutico Responsável - CRM 12345',
  );

  AttendantProfileData get data => _data;

  void updatePersonalData({
    required String fullName,
    required String email,
    required String cpf,
    required String phone,
  }) {
    _data = _data.copyWith(
      fullName: fullName,
      email: email,
      cpf: cpf,
      phone: phone,
    );
    notifyListeners();
  }
}