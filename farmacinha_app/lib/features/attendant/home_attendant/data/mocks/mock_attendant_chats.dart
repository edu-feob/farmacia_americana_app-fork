import 'package:farmacia_app/features/attendant/home_attendant/data/mocks/mock_attendant_recent_clientes.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_chat_model.dart';

class MockAttendantChats {
  static List<AttendantChat> getChats() {
    final clients = MockAttendantRecentClients.getClients();

    return [
      AttendantChat(
        id: clients[0].id,
        customerName: clients[0].name,
        preview: '"Preciso de ajuda com a dosagem do medicamento..."',
        timestamp: 'URGENTE • 2M',
        status: 'em_atendimento',
        isUrgent: true,
      ),
      AttendantChat(
        id: clients[1].id,
        customerName: clients[1].name,
        preview: '"Obrigado pelas informações, vou seguir a orientação."',
        timestamp: 'Hoje • 10:15',
        status: 'novo',
      ),
      AttendantChat(
        id: clients[2].id,
        customerName: clients[2].name,
        preview: 'Você: "O pedido já saiu para entrega."',
        timestamp: 'Hoje • 09:45',
        status: 'finalizado',
        isPositive: true,
      ),
      AttendantChat(
        id: clients[3].id,
        customerName: clients[3].name,
        preview: '"Quero confirmar se meu convênio foi aplicado."',
        timestamp: 'Ontem • 18:20',
        status: 'em_atendimento',
      ),
    ];
  }
}
