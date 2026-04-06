import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/client/catalog/view_model/catalog_view_model.dart';
import 'package:farmacia_app/features/client/catalog/view/widgets/product_card.dart';
import 'package:farmacia_app/features/client/catalog/view/widgets/category_chip.dart';
import 'package:farmacia_app/features/client/catalog/view/widgets/promo_banner.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // Instanciando a ViewModel
  final CatalogViewModel viewModel = CatalogViewModel();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final crossAxisCount = isMobile ? 2 : 3;

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: _buildAppBar(context),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          // Estado de carregamento
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Pallete.gradient3),
              ),
            );
          }

          // Erro ao carregar
          if (viewModel.errorMessage != null) {
            return _buildErrorState();
          }

          // Estado normal
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),

                // ===== BARRA DE BUSCA =====
                _buildSearchBar(context),

                const SizedBox(height: 16),

                // ===== CATEGORIAS =====
                _buildCategoryFilter(),

                const SizedBox(height: 20),

                // ===== BANNER PROMOCIONAL =====
                if (viewModel.getPromotionalProducts().isNotEmpty)
                  _buildPromoBanner(),

                const SizedBox(height: 20),

                // ===== PRODUTOS GRID =====
                if (viewModel.filteredProducts.isNotEmpty)
                  _buildProductsGrid(crossAxisCount)
                else
                  _buildEmptyState(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===== WIDGETS PRIVADOS =====

  /// AppBar com logo e ícones de ações
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Pallete.backgroundColor,
      title: const Text(
        'Catálogo',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 50, 50, 50),
        ),
      ),
      centerTitle: false,
      actions: [
        // Ícone de carrinho
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Center(
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Pallete.gradient3,
                    size: 26,
                  ),
                  onPressed: () {
                    debugPrint('Abrir carrinho');
                    // Navegar para cart_screen
                  },
                ),
                // Badge de quantidade
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 69, 58),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Barra de busca
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Pallete.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Pallete.borderColor,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: viewModel.searchController,
          decoration: InputDecoration(
            hintText: 'Buscar medicamentos, produtos...',
            hintStyle: const TextStyle(
              color: Pallete.textColor,
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Pallete.textColor,
              size: 22,
            ),
            suffixIcon: viewModel.searchQuery.isNotEmpty
                ? GestureDetector(
                    onTap: viewModel.clearFilters,
                    child: const Icon(
                      Icons.close_rounded,
                      color: Pallete.textColor,
                      size: 20,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 8,
            ),
          ),
          style: const TextStyle(
            color: Color.fromARGB(255, 50, 50, 50),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// Filtro de categorias (scroll horizontal)
  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: viewModel.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = viewModel.categories[index];
          final isSelected =
              viewModel.selectedCategoryId == category.id ||
              (viewModel.selectedCategoryId.isEmpty && category.id == 'all');

          return CategoryChip(
            label: category.name,
            icon: category.icon,
            isSelected: isSelected,
            productCount: category.productCount,
            onTap: () {
              viewModel.selectCategory(category.id);
            },
          );
        },
      ),
    );
  }

  /// Banner promocional destaque
  Widget _buildPromoBanner() {
    final promoProducts = viewModel.getPromotionalProducts();
    final mainPromo = promoProducts.isNotEmpty ? promoProducts.first : null;

    if (mainPromo == null) return const SizedBox.shrink();

    return PromoBanner(
      title: 'Super Oferta\nMedicamentos',
      subtitle: 'PROMOÇÃO DO MÊS',
      discountPercentage: mainPromo.discountPercentage,
      ctaText: 'COMPRAR AGORA',
      icon: Icons.local_pharmacy_rounded,
      backgroundColor: Pallete.gradient1,
      onTap: () {
        debugPrint('Banner promocional clicado');
        viewModel.selectCategory('medicamentos');
      },
      onCtaTapped: () {
        debugPrint('CTA do banner clicado');
        viewModel.selectCategory('medicamentos');
      },
    );
  }

  /// Grid de produtos
  Widget _buildProductsGrid(int crossAxisCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemCount: viewModel.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = viewModel.filteredProducts[index];

          return ProductCard(
            imageUrl: product.imageUrl,
            productName: product.name,
            price: product.price,
            rating: product.rating,
            reviewCount: product.reviewCount,
            isOnPromotion: product.isOnPromotion,
            discountPercentage: product.discountPercentage,
            onTap: () => viewModel.viewProductDetail(product),
            onAddToCart: () => viewModel.addToCart(product),
          );
        },
      ),
    );
  }

  /// Estado vazio (sem produtos encontrados)
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 80,
              color: Pallete.borderColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Nenhum produto encontrado',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Pallete.textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tente ajustar seus filtros ou busca',
              style: TextStyle(
                fontSize: 14,
                color: Pallete.textColor,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: viewModel.clearFilters,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Pallete.actionButton,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Limpar Filtros',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 50, 50, 50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Estado de erro
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: Color.fromARGB(255, 255, 69, 58),
            ),
            const SizedBox(height: 16),
            const Text(
              'Erro ao carregar catálogo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 50, 50, 50),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.errorMessage ?? 'Tente novamente mais tarde',
              style: const TextStyle(
                fontSize: 14,
                color: Pallete.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                // Reimplementar lógica de reload
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Pallete.gradient3,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Tentar Novamente',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallete.whiteColor,
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
