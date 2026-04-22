import 'package:farmacia_app/features/attendant/home_attendant/data/mocks/mock_attendant_recent_clientes.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_chat_message_model.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_conversation_model.dart';

class MockAttendantConversations {
  static List<AttendantConversation> getConversations() {
    final clients = MockAttendantRecentClients.getClients();

    return [
      AttendantConversation(
        client: clients[0],
        statusLabel: 'ONLINE',
        orderCode: '#8829',
        isClientTyping: true,
        messages: const [
          AttendantChatMessage(
            id: 'c1-m1',
            type: AttendantMessageType.text,
            isFromAttendant: false,
            time: '14:20',
            message:
                'Olá! Gostaria de saber se o medicamento Xarelto 20mg que pedi já está disponível para retirada ou se virá pela entrega.',
          ),
          AttendantChatMessage(
            id: 'c1-m2',
            type: AttendantMessageType.text,
            isFromAttendant: true,
            time: '14:22',
            showReadReceipt: true,
            message:
                'Olá, Adriana! Verifiquei aqui no sistema. Seu pedido já foi processado e está na rota de entrega. A previsão é que chegue em até 40 minutos.',
          ),
          AttendantChatMessage(
            id: 'c1-m3',
            type: AttendantMessageType.attachment,
            isFromAttendant: false,
            time: '14:25',
            fileName: 'receita_medica_final.pdf',
            fileDetails: '2.4 MB • PDF',
            message:
                'Perfeito! Já deixei a receita digital anexada aqui caso o entregador precise validar algo. Obrigada pela atenção.',
          ),
        ],
      ),
      AttendantConversation(
        client: clients[1],
        statusLabel: 'ONLINE',
        orderCode: '#7412',
        messages: const [
          AttendantChatMessage(
            id: 'c2-m1',
            type: AttendantMessageType.text,
            isFromAttendant: false,
            time: '09:08',
            message:
                'Bom dia! Meu antibiótico ficou separado com o desconto do convênio?',
          ),
          AttendantChatMessage(
            id: 'c2-m2',
            type: AttendantMessageType.text,
            isFromAttendant: true,
            time: '09:10',
            showReadReceipt: true,
            message:
                'Bom dia, João! Conferi no sistema e o convênio foi aplicado corretamente. A amoxicilina já está reservada para retirada até as 18h.',
          ),
          AttendantChatMessage(
            id: 'c2-m3',
            type: AttendantMessageType.text,
            isFromAttendant: false,
            time: '09:12',
            message: 'Perfeito, vou passar aí depois do almoço. Obrigado!',
          ),
        ],
      ),
      AttendantConversation(
        client: clients[2],
        statusLabel: 'ONLINE',
        orderCode: '#5184',
        messages: const [
          AttendantChatMessage(
            id: 'c3-m1',
            type: AttendantMessageType.text,
            isFromAttendant: false,
            time: '11:31',
            message:
                'Oi! O teste de glicemia pode ser feito hoje ainda na unidade do centro?',
          ),
          AttendantChatMessage(
            id: 'c3-m2',
            type: AttendantMessageType.text,
            isFromAttendant: true,
            time: '11:34',
            showReadReceipt: true,
            message:
                'Pode sim, Roberta. Temos encaixe até 16h30. Se quiser, eu já deixo seu atendimento pré-cadastrado para agilizar na recepção.',
          ),
          AttendantChatMessage(
            id: 'c3-m3',
            type: AttendantMessageType.text,
            isFromAttendant: false,
            time: '11:36',
            message: 'Quero sim! Pode deixar no meu nome, por favor.',
          ),
        ],
      ),
      AttendantConversation(
        client: clients[3],
        statusLabel: 'ONLINE',
        orderCode: '#6631',
        messages: const [
          AttendantChatMessage(
            id: 'c4-m1',
            type: AttendantMessageType.text,
            isFromAttendant: false,
            time: '17:42',
            message:
                'Boa tarde. Minha entrega saiu para o bairro São Pedro ou ainda está em separação?',
          ),
          AttendantChatMessage(
            id: 'c4-m2',
            type: AttendantMessageType.text,
            isFromAttendant: true,
            time: '17:45',
            showReadReceipt: true,
            message:
                'Boa tarde, Paulo! Seu pedido saiu da loja há poucos minutos e já está com o entregador responsável pela sua região.',
          ),
          AttendantChatMessage(
            id: 'c4-m3',
            type: AttendantMessageType.text,
            isFromAttendant: false,
            time: '17:47',
            message: 'Ótimo, vou ficar atento. Obrigado pelo retorno.',
          ),
        ],
      ),
    ];
  }
}
