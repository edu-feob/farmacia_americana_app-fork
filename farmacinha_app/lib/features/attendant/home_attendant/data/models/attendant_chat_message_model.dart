enum AttendantMessageType { text, attachment }

class AttendantChatMessage {
  final String id;
  final AttendantMessageType type;
  final bool isFromAttendant;
  final String time;
  final String? message;
  final String? fileName;
  final String? fileDetails;
  final bool showReadReceipt;

  const AttendantChatMessage({
    required this.id,
    required this.type,
    required this.isFromAttendant,
    required this.time,
    this.message,
    this.fileName,
    this.fileDetails,
    this.showReadReceipt = false,
  });
}
