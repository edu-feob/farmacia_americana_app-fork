import 'package:flutter/material.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/mocks/mock_attendant_chats.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/mocks/mock_attendant_status.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_chat_model.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_status_model.dart';

class HomeAttendantViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  List<AttendantChat> _allChats = [];
  List<AttendantChat> _filteredChats = [];
  List<AttendantStatus> _baseStatusList = [];
  List<AttendantStatus> _statusList = [];

  String _selectedStatus = 'em_atendimento';
  int _currentTab = 0;

  List<AttendantChat> get chats => _filteredChats;
  List<AttendantStatus> get statusList => _statusList;
  String get selectedStatus => _selectedStatus;
  int get currentTab => _currentTab;

  HomeAttendantViewModel() {
    _allChats = MockAttendantChats.getChats();
    _baseStatusList = MockAttendantStatus.getStatusList();
    _updateStatusCounts();
    _applyFilters();
    searchController.addListener(_applyFilters);
  }

  void selectStatus(String statusId) {
    _selectedStatus = statusId;
    _applyFilters();
  }

  void setTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  void _applyFilters() {
    final query = searchController.text.trim().toLowerCase();

    _filteredChats = _allChats.where((chat) {
      final statusMatch = chat.status == _selectedStatus;
      final queryMatch =
          query.isEmpty ||
          chat.customerName.toLowerCase().contains(query) ||
          chat.preview.toLowerCase().contains(query);
      return statusMatch && queryMatch;
    }).toList();

    notifyListeners();
  }

  void _updateStatusCounts() {
    _statusList = _baseStatusList.map((status) {
      final count = _allChats.where((chat) => chat.status == status.id).length;

      return AttendantStatus(
        id: status.id,
        label: status.label,
        count: count,
        icon: status.icon,
      );
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
