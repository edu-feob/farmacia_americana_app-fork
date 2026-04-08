import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/client/purchase_history/view_model/purchase_history_view_model.dart';
import 'package:farmacia_app/features/client/purchase_history/view/widgets/purchase_item_card.dart';
import 'package:farmacia_app/features/client/orders/detail/view/order_detail_screen.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  final PurchaseHistoryViewModel viewModel = PurchaseHistoryViewModel();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Pallete.primaryRed),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Histórico de Compras',
          style: TextStyle(
            color: Pallete.primaryRed,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Pallete.primaryRed),
              ),
            );
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Pallete.textColor),
              ),
            );
          }

          if (viewModel.history.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    size: 72,
                    color: Pallete.borderColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nenhuma compra realizada ainda',
                    style: TextStyle(
                      color: Pallete.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Card de resumo
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Pallete.primaryRed.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Pallete.primaryRed.withOpacity(0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryItem(
                          label: 'Total de compras',
                          value: '${viewModel.totalOrders}',
                          icon: Icons.shopping_bag_rounded,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 36,
                        color: Pallete.primaryRed.withOpacity(0.2),
                      ),
                      Expanded(
                        child: _SummaryItem(
                          label: 'Total gasto',
                          value:
                              'R\$ ${viewModel.totalSpent.toStringAsFixed(2).replaceAll('.', ',')}',
                          icon: Icons.attach_money_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Lista
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  itemCount: viewModel.history.length,
                  itemBuilder: (context, index) {
                    final order = viewModel.history[index];
                    return PurchaseItemCard(
                      order: order,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => OrderDetailScreen(order: order),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(icon, color: Pallete.primaryRed, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: Pallete.textColor,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF291715),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
