import 'package:farmacia_app/features/client/chat/data/models/client_chat_message_model.dart';

class ClientChatConversation {
  final String attendantName;
  final String attendantRole;
  final String statusLabel;
  final String orderCode;
  final bool isAttendantTyping;
  final List<ClientChatMessage> messages;

  const ClientChatConversation({
    required this.attendantName,
    required this.attendantRole,
    required this.statusLabel,
    required this.orderCode,
    required this.messages,
    this.isAttendantTyping = false,
  });

  ClientChatConversation copyWith({
    String? attendantName,
    String? attendantRole,
    String? statusLabel,
    String? orderCode,
    bool? isAttendantTyping,
    List<ClientChatMessage>? messages,
  }) {
    return ClientChatConversation(
      attendantName: attendantName ?? this.attendantName,
      attendantRole: attendantRole ?? this.attendantRole,
      statusLabel: statusLabel ?? this.statusLabel,
      orderCode: orderCode ?? this.orderCode,
      isAttendantTyping: isAttendantTyping ?? this.isAttendantTyping,
      messages: messages ?? this.messages,
    );
  }
}
