import 'package:farmacia_app/features/client/chat/data/models/client_chat_attachment_model.dart';
import 'package:farmacia_app/features/client/chat/data/models/client_chat_conversation_model.dart';
import 'package:farmacia_app/features/client/chat/data/models/client_chat_message_model.dart';

class MockClientChatConversation {
  static ClientChatConversation getConversation() {
    return const ClientChatConversation(
      attendantName: 'Camila Souza',
      attendantRole: 'Atendimento Farmacia Americana',
      statusLabel: 'Online agora',
      orderCode: '#8829',
      isAttendantTyping: false,
      messages: [
        ClientChatMessage(
          id: 'm1',
          isFromClient: false,
          time: '14:18',
          text:
              'Ola! Sou a Camila, do atendimento da Farmacia Americana. Posso te ajudar com seu pedido, receita ou disponibilidade de medicamentos.',
        ),
        ClientChatMessage(
          id: 'm2',
          isFromClient: true,
          time: '14:20',
          showReadReceipt: true,
          text:
              'Oi, Camila! Gostaria de confirmar se meu pedido com losartana ja saiu para entrega.',
        ),
        ClientChatMessage(
          id: 'm3',
          isFromClient: false,
          time: '14:22',
          text:
              'Seu pedido ja esta em separacao final e deve seguir para a entrega em poucos minutos.',
        ),
        ClientChatMessage(
          id: 'm4',
          isFromClient: true,
          time: '14:24',
          showReadReceipt: true,
          text:
              'Perfeito. Tambem vou anexar a foto da receita caso precise validar por ai.',
        ),
        ClientChatMessage(
          id: 'm5',
          isFromClient: true,
          time: '14:25',
          showReadReceipt: true,
          attachment: ClientChatAttachment(
            id: 'a1',
            type: ClientAttachmentType.photo,
            fileName: 'receita_frente.jpg',
            fileDetails: '1.8 MB • Foto',
          ),
        ),
      ],
    );
  }
}
