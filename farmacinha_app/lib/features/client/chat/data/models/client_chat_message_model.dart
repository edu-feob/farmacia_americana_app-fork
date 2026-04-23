import 'package:farmacia_app/features/client/chat/data/models/client_chat_attachment_model.dart';

class ClientChatMessage {
  final String id;
  final bool isFromClient;
  final String time;
  final String? text;
  final ClientChatAttachment? attachment;
  final bool showReadReceipt;

  const ClientChatMessage({
    required this.id,
    required this.isFromClient,
    required this.time,
    this.text,
    this.attachment,
    this.showReadReceipt = false,
  });

  bool get hasAttachment => attachment != null;
}
