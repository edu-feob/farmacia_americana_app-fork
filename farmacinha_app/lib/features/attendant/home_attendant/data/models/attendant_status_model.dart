import 'package:flutter/material.dart';

class AttendantStatus {
  final String id;
  final String label;
  final int count;
  final IconData icon;

  const AttendantStatus({
    required this.id,
    required this.label,
    required this.count,
    required this.icon,
  });
}