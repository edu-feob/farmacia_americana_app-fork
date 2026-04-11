import 'package:flutter/material.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/mocks/mock_attendant_recent_clientes.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_search_client_model.dart';


class AttendantSearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  List<AttendantSearchClient> _allClients = [];
  List<AttendantSearchClient> _filteredClients = [];

  List<AttendantSearchClient> get clients => _filteredClients;

  AttendantSearchViewModel() {
    _allClients = MockAttendantRecentClients.getClients();
    _applyFilters();
    searchController.addListener(_applyFilters);
  }

  void onSearchPressed() {
    _applyFilters();
  }

  void _applyFilters() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      _filteredClients = List<AttendantSearchClient>.from(_allClients);
      notifyListeners();
      return;
    }

    _filteredClients = _allClients.where((client) {
      return client.name.toLowerCase().contains(query) ||
          client.cpf.toLowerCase().contains(query) ||
          client.initials.toLowerCase().contains(query);
    }).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}