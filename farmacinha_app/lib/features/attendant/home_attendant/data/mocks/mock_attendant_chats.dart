import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_chat_model.dart';

class MockAttendantChats {
  static List<AttendantChat> getChats() {
    return const [
      AttendantChat(
        id: 'chat-1',
        customerName: 'Ana Paula Silveira',
        preview: '"Preciso de ajuda com a dosagem ...',
        timestamp: 'URGENTE • 2M',
        status: 'em_atendimento',
        isUrgent: true,
      ),
      AttendantChat(
        id: 'chat-2',
        customerName: 'Marcos Oliveira',
        preview: '"Obrigado pelas informações, vou ...',
        timestamp: 'Hoje • 10:15',
        status: 'novo',
      ),
      AttendantChat(
        id: 'chat-3',
        customerName: 'Beatriz Santos',
        preview: 'Você: "O pedido já saiu para entre...',
        timestamp: 'Hoje • 09:45',
        status: 'finalizado',
        isPositive: true,
      ),
    ];
  }
}