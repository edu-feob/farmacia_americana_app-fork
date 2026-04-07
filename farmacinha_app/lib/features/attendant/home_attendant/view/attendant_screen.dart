import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class HomeAttendantScreen extends StatelessWidget {
  const HomeAttendantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Pallete.primaryRed, width: 2),
                color: const Color(0xFFECEFF4),
              ),
              child: const Icon(Icons.person, color: Color(0xFF1A1A1A)),
            ),
            const SizedBox(width: 12),
            const Text(
              'PAINEL AMERICANA',
              style: TextStyle(
                color: Color(0xFF101828),
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Color(0xFF111827)),
              ),
              Positioned(
                right: 9,
                top: 8,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Color(0xFF111827))),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('BUSCAR ATENDIMENTO', style: _titleStyle),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Nome ou CPF do cliente...',
                        hintStyle: const TextStyle(color: Color(0xFF8B9BB4), fontSize: 30/2),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF8B9BB4)),
                        filled: true,
                        fillColor: const Color(0xFFE9EEF5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEEDEF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: Pallete.primaryRed, width: 4)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_rounded, color: Pallete.primaryRed, size: 34),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mensagens Urgentes (2)', style: TextStyle(fontSize: 16, color: Pallete.primaryRed, fontWeight: FontWeight.w700)),
                          SizedBox(height: 2),
                          Text('Resposta imediata necessária (>5 min).', style: TextStyle(fontSize: 14, color: Color(0xFFEA5A63))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('FILTRAR POR STATUS', style: TextStyle(color: Color(0xFF8B9BB4), fontWeight: FontWeight.w600, letterSpacing: 1.2, fontSize: 14)),
                    SizedBox(height: 14),
                    _StatusTile(label: 'Em Atendimento', count: 12, icon: Icons.chat_bubble_outline, selected: true),
                    _StatusTile(label: 'Novo', count: 5, icon: Icons.new_releases_outlined),
                    _StatusTile(label: 'Finalizado', count: 128, icon: Icons.check_circle_outline),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Text('CONVERSAS\nATIVAS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 42/2, color: Color(0xFF0B132B)))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F8EF),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFB6E8CB)),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(radius: 4, backgroundColor: Color(0xFF27C281)),
                        SizedBox(width: 8),
                        Text('Sistema\nOnline', style: TextStyle(color: Color(0xFF036B44), fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Color(0xFFD9E0EB)),
              const SizedBox(height: 10),
              const _ChatItem(name: 'Ana Paula Silveira', subtitle: '"Preciso de ajuda com a dosagem ...', rightLabel: 'URGENTE • 2M', urgent: true),
              const SizedBox(height: 12),
              const _ChatItem(name: 'Marcos Oliveira', subtitle: '"Obrigado pelas informações, vou ...', rightLabel: 'Hoje • 10:15'),
              const SizedBox(height: 12),
              const _ChatItem(name: 'Beatriz Santos', subtitle: 'Você: "O pedido já saiu para entre...', rightLabel: 'Hoje • 09:45', positive: true),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B1534),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: const Text('CARREGAR CONVERSAS ANTERIORES', style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Pallete.primaryRed,
        unselectedItemColor: const Color(0xFF94A3B8),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'BUSCA'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'CHAT'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL'),
        ],
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD5DEE8)),
      ),
      child: child,
    );
  }
}

const _titleStyle = TextStyle(
  fontSize: 15,
  letterSpacing: 1.6,
  fontWeight: FontWeight.w700,
  color: Color(0xFF111827),
);

class _StatusTile extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final bool selected;

  const _StatusTile({
    required this.label,
    required this.count,
    required this.icon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEF1725) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: selected ? Colors.white : const Color(0xFF94A3B8)),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF111827),
              fontSize: 17,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFFC5661) : const Color(0xFFE9EEF5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF334155),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final String name;
  final String subtitle;
  final String rightLabel;
  final bool urgent;
  final bool positive;

  const _ChatItem({
    required this.name,
    required this.subtitle,
    required this.rightLabel,
    this.urgent = false,
    this.positive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD5DEE8)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 36)),
              if (urgent)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Pallete.primaryRed,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.priority_high, size: 12, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                    ),
                    Text(
                      rightLabel,
                      style: TextStyle(
                        color: urgent ? Pallete.primaryRed : const Color(0xFF94A3B8),
                        fontWeight: urgent ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: positive ? const Color(0xFF059669) : const Color(0xFF516B8B),
                    fontSize: 20 / 2,
                    fontStyle: positive ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}