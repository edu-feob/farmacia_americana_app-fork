import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/client/account/view/account_screen.dart';
import 'package:farmacia_app/features/client/chat/data/models/client_chat_attachment_model.dart';
import 'package:farmacia_app/features/client/chat/data/models/client_chat_message_model.dart';
import 'package:farmacia_app/features/client/chat/view_model/client_chat_view_model.dart';
import 'package:farmacia_app/features/client/home_client/view/home_client_screen.dart';
import 'package:farmacia_app/features/client/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ClientChatScreen extends StatefulWidget {
  const ClientChatScreen({super.key});

  @override
  State<ClientChatScreen> createState() => _ClientChatScreenState();
}

class _ClientChatScreenState extends State<ClientChatScreen> {
  late final ClientChatViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ClientChatViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_rounded, color: Pallete.primaryRed),
        ),
        titleSpacing: 0,
        title: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            final conversation = _viewModel.conversation;

            return Row(
              children: [
                const _SupportAvatar(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        conversation.attendantName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF291715),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${conversation.statusLabel} • Pedido ${conversation.orderCode}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF8F6A64),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final conversation = _viewModel.conversation;

          return Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0EE),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFFFD7D1)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Pallete.accentYellow.withOpacity(0.28),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.attach_file_rounded,
                        color: Color(0xFF6E5C00),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Envie fotos da receita ou documentos para agilizar seu atendimento.',
                        style: TextStyle(
                          color: Color(0xFF5D3F3C),
                          fontSize: 13.5,
                          height: 1.35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFF8F7),
                        Color(0xFFFFF4F1),
                        Color(0xFFFFF0EE),
                      ],
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    children: [
                      const Center(child: _DayPill(label: 'Atendimento de hoje')),
                      const SizedBox(height: 22),
                      ...conversation.messages.map(
                        (message) => _MessageBubble(message: message),
                      ),
                      if (conversation.isAttendantTyping) ...[
                        const SizedBox(height: 6),
                        const _TypingIndicator(),
                      ],
                    ],
                  ),
                ),
              ),
              _ChatComposer(
                controller: _viewModel.messageController,
                onAttach: _showAttachmentOptions,
                onSend: _viewModel.sendMessage,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: _onBottomBarTap,
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Anexar arquivo',
                  style: TextStyle(
                    color: Color(0xFF291715),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Escolha o tipo de anexo que deseja enviar para o atendimento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Pallete.textColor,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                _AttachmentOptionTile(
                  icon: Icons.photo_camera_back_rounded,
                  iconColor: const Color(0xFF005F93),
                  iconBackgroundColor: const Color(0xFFCDE5FF),
                  title: 'Foto',
                  subtitle: 'Receita, embalagem ou imagem do produto',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _viewModel.attachMedia(ClientAttachmentType.photo);
                  },
                ),
                const SizedBox(height: 12),
                _AttachmentOptionTile(
                  icon: Icons.description_rounded,
                  iconColor: Pallete.primaryRed,
                  iconBackgroundColor: const Color(0xFFFFE3DF),
                  title: 'Documento',
                  subtitle: 'PDF, laudo, prescricao ou comprovante',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _viewModel.attachMedia(ClientAttachmentType.document);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onBottomBarTap(int index) {
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeClientScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 1) {
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushNamed(AppRoutes.cart);
      return;
    }

    if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AccountScreen()),
      );
    }
  }
}

class _SupportAvatar extends StatelessWidget {
  const _SupportAvatar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE3DF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.support_agent_rounded,
            color: Pallete.primaryRed,
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xFF41C86A),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.8),
            ),
          ),
        ),
      ],
    );
  }
}

class _DayPill extends StatelessWidget {
  final String label;

  const _DayPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEAE6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF9A6E66),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ClientChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isFromClient = message.isFromClient;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isFromClient
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: isFromClient
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 295),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isFromClient ? Pallete.primaryRed : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isFromClient ? 18 : 6),
                    bottomRight: Radius.circular(isFromClient ? 6 : 18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: message.hasAttachment
                    ? _AttachmentPreview(message: message)
                    : Text(
                        message.text ?? '',
                        style: TextStyle(
                          color: isFromClient ? Colors.white : const Color(0xFF3A2A27),
                          fontSize: 15.5,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.time,
                style: const TextStyle(
                  color: Color(0xFF8F817A),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (message.showReadReceipt) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.done_all_rounded,
                  size: 15,
                  color: Color(0xFFB88A8A),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _AttachmentPreview extends StatelessWidget {
  final ClientChatMessage message;

  const _AttachmentPreview({required this.message});

  @override
  Widget build(BuildContext context) {
    final attachment = message.attachment!;
    final isPhoto = attachment.type == ClientAttachmentType.photo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isPhoto ? const Color(0x33FFFFFF) : const Color(0xFFF8ECEA),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isPhoto
                      ? Colors.white.withOpacity(0.16)
                      : const Color(0xFFFFE3DF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isPhoto ? Icons.photo_library_rounded : Icons.picture_as_pdf_rounded,
                  color: isPhoto ? Colors.white : Pallete.primaryRed,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachment.fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isPhoto ? Colors.white : const Color(0xFF4A4A4A),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      attachment.fileDetails,
                      style: TextStyle(
                        color: isPhoto
                            ? Colors.white.withOpacity(0.82)
                            : const Color(0xFF8B8B8B),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if ((message.text ?? '').isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            message.text!,
            style: TextStyle(
              color: message.isFromClient ? Colors.white : const Color(0xFF3A2A27),
              fontSize: 15.5,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 6),
      child: Text(
        'Atendente digitando...',
        style: TextStyle(
          color: Color(0xFF9A887F),
          fontSize: 13,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAttach;
  final VoidCallback onSend;

  const _ChatComposer({
    required this.controller,
    required this.onAttach,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
        decoration: const BoxDecoration(
          color: Color(0xFFFFF8F7),
          border: Border(top: BorderSide(color: Color(0xFFFFDDD8))),
        ),
        child: Row(
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: onAttach,
                borderRadius: BorderRadius.circular(16),
                child: const SizedBox(
                  width: 52,
                  height: 52,
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Pallete.primaryRed,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 52,
                padding: const EdgeInsets.only(left: 16, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  decoration: const InputDecoration(
                    hintText: 'Escreva sua mensagem...',
                    hintStyle: TextStyle(
                      color: Color(0xFF9D9D9D),
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Pallete.primaryRed,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: onSend,
                borderRadius: BorderRadius.circular(16),
                child: const SizedBox(
                  width: 54,
                  height: 54,
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AttachmentOptionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF291715),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Pallete.textColor,
                      fontSize: 12.5,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Pallete.textColor,
            ),
          ],
        ),
      ),
    );
  }
}
