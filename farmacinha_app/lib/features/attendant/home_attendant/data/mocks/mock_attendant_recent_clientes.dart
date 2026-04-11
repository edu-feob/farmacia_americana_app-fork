import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_search_client_model.dart';

class MockAttendantRecentClients {
  static List<AttendantSearchClient> getClients() {
    return const [
      AttendantSearchClient(
        id: 'client-1',
        initials: 'AM',
        name: 'ADRIANA MENDONÇA',
        cpf: '452.XXX.XX8-12',
        timeLabel: 'HÁ 2 HORAS',
      ),
      AttendantSearchClient(
        id: 'client-2',
        initials: 'JS',
        name: 'JOÃO SILVA COSTA',
        cpf: '128.XXX.XX7-90',
        timeLabel: 'ONTEM',
      ),
      AttendantSearchClient(
        id: 'client-3',
        initials: 'RC',
        name: 'ROBERTA CAVALCANTI',
        cpf: '832.XXX.XX3-44',
        timeLabel: '15 OUT',
      ),
      AttendantSearchClient(
        id: 'client-4',
        initials: 'PB',
        name: 'PAULO BATISTA',
        cpf: '091.XXX.XX1-22',
        timeLabel: '12 OUT',
      ),
    ];
  }
}