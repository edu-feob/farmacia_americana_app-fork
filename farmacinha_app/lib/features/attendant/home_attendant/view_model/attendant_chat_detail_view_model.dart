import 'package:flutter/material.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/mocks/mock_attendant_conversations.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_chat_message_model.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_conversation_model.dart';

class AttendantChatDetailViewModel extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();

  final List<AttendantConversation> _conversations =
      List<AttendantConversation>.from(
        MockAttendantConversations.getConversations(),
      );

  String? _selectedClientId;

  AttendantConversation? get currentConversation {
    if (_conversations.isEmpty) return null;

    final selectedId = _selectedClientId ?? _conversations.first.client.id;
    final conversationIndex = _conversations.indexWhere(
      (conversation) => conversation.client.id == selectedId,
    );

    if (conversationIndex == -1) {
      return _conversations.first;
    }

    return _conversations[conversationIndex];
  }

  void selectClient(String clientId) {
    if (_conversations.any(
      (conversation) => conversation.client.id == clientId,
    )) {
      _selectedClientId = clientId;
      notifyListeners();
    }
  }

  void sendMessage() {
    final draft = messageController.text.trim();
    final conversation = currentConversation;

    if (draft.isEmpty || conversation == null) return;

    final updatedMessages = [
      ...conversation.messages,
      AttendantChatMessage(
        id: 'local-${DateTime.now().microsecondsSinceEpoch}',
        type: AttendantMessageType.text,
        isFromAttendant: true,
        time: _formatCurrentTime(),
        message: draft,
        showReadReceipt: true,
      ),
    ];

    final conversationIndex = _conversations.indexWhere(
      (item) => item.client.id == conversation.client.id,
    );

    _conversations[conversationIndex] = conversation.copyWith(
      messages: updatedMessages,
      isClientTyping: false,
    );

    messageController.clear();
    notifyListeners();
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
