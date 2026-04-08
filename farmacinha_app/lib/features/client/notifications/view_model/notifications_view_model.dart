import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/notifications/data/models/notification_model.dart';
import 'package:farmacia_app/features/client/notifications/data/mocks/mock_notifications.dart';

class NotificationsViewModel extends ChangeNotifier {
  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;
  bool get hasUnread => unreadCount > 0;

  NotificationsViewModel() {
    _load();
  }

  void _load() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 400), () {
      _notifications = MockNotifications.getNotifications();
      _isLoading = false;
      notifyListeners();
    });
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (final n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }
}
