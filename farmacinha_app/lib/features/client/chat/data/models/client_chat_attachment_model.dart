enum ClientAttachmentType { photo, document }

class ClientChatAttachment {
  final String id;
  final ClientAttachmentType type;
  final String fileName;
  final String fileDetails;

  const ClientChatAttachment({
    required this.id,
    required this.type,
    required this.fileName,
    required this.fileDetails,
  });
}
