import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_chat_message_model.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_search_client_model.dart';

class AttendantConversation {
  final AttendantSearchClient client;
  final String statusLabel;
  final String orderCode;
  final bool isClientTyping;
  final List<AttendantChatMessage> messages;

  const AttendantConversation({
    required this.client,
    required this.statusLabel,
    required this.orderCode,
    required this.messages,
    this.isClientTyping = false,
  });

  AttendantConversation copyWith({
    AttendantSearchClient? client,
    String? statusLabel,
    String? orderCode,
    bool? isClientTyping,
    List<AttendantChatMessage>? messages,
  }) {
    return AttendantConversation(
      client: client ?? this.client,
      statusLabel: statusLabel ?? this.statusLabel,
      orderCode: orderCode ?? this.orderCode,
      isClientTyping: isClientTyping ?? this.isClientTyping,
      messages: messages ?? this.messages,
    );
  }
}
