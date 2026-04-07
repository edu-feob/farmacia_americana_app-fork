import 'package:flutter/material.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_status_model.dart';

class MockAttendantStatus {
  static List<AttendantStatus> getStatusList() {
    return const [
      AttendantStatus(
        id: 'em_atendimento',
        label: 'Em Atendimento',
        count: 12,
        icon: Icons.chat_bubble_outline,
      ),
      AttendantStatus(
        id: 'novo',
        label: 'Novo',
        count: 5,
        icon: Icons.new_releases_outlined,
      ),
      AttendantStatus(
        id: 'finalizado',
        label: 'Finalizado',
        count: 128,
        icon: Icons.check_circle_outline,
      ),
    ];
  }
}