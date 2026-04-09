import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/client/orders/list/view_model/orders_view_model.dart';
import 'package:farmacia_app/features/client/orders/list/view/widgets/order_item_tile.dart';
import 'package:farmacia_app/features/client/orders/detail/view/order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersViewModel viewModel = OrdersViewModel();

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
          'Meus Pedidos',
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
          return Column(
            children: [
              // Filtros
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      viewModel.filterLabels.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(viewModel.filterLabels[index]),
                          selected: viewModel.selectedFilterIndex == index,
                          onSelected: (_) => viewModel.selectFilter(index),
                          selectedColor: Pallete.primaryRed.withOpacity(0.15),
                          checkmarkColor: Pallete.primaryRed,
                          labelStyle: TextStyle(
                            color:
                                viewModel.selectedFilterIndex == index
                                    ? Pallete.primaryRed
                                    : Pallete.textColor,
                            fontWeight:
                                viewModel.selectedFilterIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            fontSize: 13,
                          ),
                          side: BorderSide(
                            color:
                                viewModel.selectedFilterIndex == index
                                    ? Pallete.primaryRed
                                    : Pallete.borderColor,
                          ),
                          backgroundColor: Pallete.whiteColor,
                          showCheckmark: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Lista
              Expanded(child: _buildBody()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody() {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: Pallete.primaryRed,
            ),
            const SizedBox(height: 12),
            Text(
              viewModel.errorMessage!,
              style: const TextStyle(color: Pallete.textColor),
            ),
          ],
        ),
      );
    }

    if (viewModel.filteredOrders.isEmpty) {
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
              'Nenhum pedido encontrado',
              style: TextStyle(
                color: Pallete.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Faça seu primeiro pedido na farmácia!',
              style: TextStyle(color: Pallete.textColor, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: viewModel.filteredOrders.length,
      itemBuilder: (context, index) {
        final order = viewModel.filteredOrders[index];
        return OrderItemTile(
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
    );
  }
}
