import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';
import 'package:farmacia_app/features/client/chat/data/mocks/mock_client_chat_conversation.dart';
import 'package:farmacia_app/features/client/chat/data/models/client_chat_attachment_model.dart';
import 'package:farmacia_app/features/client/chat/data/models/client_chat_conversation_model.dart';
import 'package:farmacia_app/features/client/chat/data/models/client_chat_message_model.dart';
import 'package:flutter/material.dart';

class ClientChatViewModel extends ChangeNotifier {
  final AuthSessionViewModel _authSession;
  final TextEditingController messageController = TextEditingController();

  ClientChatConversation _conversation =
      MockClientChatConversation.getConversation();

  ClientChatViewModel({AuthSessionViewModel? authSession})
    : _authSession = authSession ?? AuthSessionViewModel.instance;

  ClientChatConversation get conversation => _conversation;
  String get clientName => _authSession.currentUser?.name ?? 'Cliente';

  void sendMessage() {
    final draft = messageController.text.trim();

    if (draft.isEmpty) return;

    _appendMessage(
      ClientChatMessage(
        id: 'local-${DateTime.now().microsecondsSinceEpoch}',
        isFromClient: true,
        time: _formatCurrentTime(),
        text: draft,
        showReadReceipt: true,
      ),
    );

    messageController.clear();
  }

  void attachMedia(ClientAttachmentType type) {
    final fileName = _buildAttachmentName(type);
    final fileDetails = type == ClientAttachmentType.photo
        ? '2.1 MB • Foto'
        : '324 KB • Documento';

    _appendMessage(
      ClientChatMessage(
        id: 'attachment-${DateTime.now().microsecondsSinceEpoch}',
        isFromClient: true,
        time: _formatCurrentTime(),
        showReadReceipt: true,
        attachment: ClientChatAttachment(
          id: 'asset-${DateTime.now().millisecondsSinceEpoch}',
          type: type,
          fileName: fileName,
          fileDetails: fileDetails,
        ),
      ),
    );
  }

  void _appendMessage(ClientChatMessage message) {
    _conversation = _conversation.copyWith(
      isAttendantTyping: false,
      messages: [..._conversation.messages, message],
    );
    notifyListeners();
  }

  String _buildAttachmentName(ClientAttachmentType type) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    if (type == ClientAttachmentType.photo) {
      return 'foto_receita_$timestamp.jpg';
    }

    return 'documento_$timestamp.pdf';
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
