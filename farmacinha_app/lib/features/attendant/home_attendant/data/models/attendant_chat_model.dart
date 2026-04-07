class AttendantChat {
  final String id;
  final String customerName;
  final String preview;
  final String timestamp;
  final bool isUrgent;
  final bool isPositive;
  final String status;

  const AttendantChat({
    required this.id,
    required this.customerName,
    required this.preview,
    required this.timestamp,
    required this.status,
    this.isUrgent = false,
    this.isPositive = false,
  });
}