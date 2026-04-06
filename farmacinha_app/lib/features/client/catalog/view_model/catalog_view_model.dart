import 'package:flutter/material.dart';

// Modelo simplificado de Produto
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String category;
  final bool isOnPromotion;
  final int? discountPercentage;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.isOnPromotion = false,
    this.discountPercentage,
  });
}

// Modelo de Categoria
class Category {
  final String id;
  final String name;
  final IconData icon;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
  });
}

class CatalogViewModel extends ChangeNotifier {
  // ===== DADOS PRIVADOS =====
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Category> _categories = [];

  String _selectedCategoryId = '';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController searchController = TextEditingController();

  // ===== GETTERS =====
  List<Product> get filteredProducts => _filteredProducts;
  List<Category> get categories => _categories;
  String get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ===== CONSTRUTOR =====
  CatalogViewModel() {
    _initializeCatalog();
    searchController.addListener(_onSearchChanged);
  }

  // ===== MÉTODOS PRIVADOS =====

  /// Inicializa o catálogo com dados mockados
  void _initializeCatalog() {
    _setLoading(true);
    _errorMessage = null;

    // Simular latência de rede
    Future.delayed(const Duration(milliseconds: 800), () {
      _allProducts = _generateMockProducts();
      _categories = _generateMockCategories();
      _filteredProducts = _allProducts;
      _setLoading(false);
      notifyListeners();
    });
  }

  /// Gera produtos mockados
  List<Product> _generateMockProducts() {
    return [
      // Medicamentos
      Product(
        id: '1',
        name: 'Dipirona 500mg',
        price: 15.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.8,
        reviewCount: 324,
        category: 'medicamentos',
        isOnPromotion: true,
        discountPercentage: 20,
      ),
      Product(
        id: '2',
        name: 'Vitamina C 1000mg',
        price: 45.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.6,
        reviewCount: 256,
        category: 'vitaminas',
        isOnPromotion: true,
        discountPercentage: 15,
      ),
      Product(
        id: '3',
        name: 'Omeprazol 20mg',
        price: 28.50,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.9,
        reviewCount: 512,
        category: 'medicamentos',
      ),
      Product(
        id: '4',
        name: 'Antitérmico Infantil',
        price: 22.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.7,
        reviewCount: 189,
        category: 'medicamentos',
      ),

      // Higiene
      Product(
        id: '5',
        name: 'Sabonete Líquido 250ml',
        price: 8.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.5,
        reviewCount: 478,
        category: 'higiene',
        isOnPromotion: true,
        discountPercentage: 25,
      ),
      Product(
        id: '6',
        name: 'Álcool Gel 500ml',
        price: 12.50,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.4,
        reviewCount: 645,
        category: 'higiene',
      ),
      Product(
        id: '7',
        name: 'Colgate Total 90g',
        price: 7.50,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.8,
        reviewCount: 832,
        category: 'higiene',
        isOnPromotion: true,
        discountPercentage: 10,
      ),

      // Beleza
      Product(
        id: '8',
        name: 'Hidratante Facial 50ml',
        price: 59.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.7,
        reviewCount: 392,
        category: 'beleza',
        isOnPromotion: true,
        discountPercentage: 30,
      ),
      Product(
        id: '9',
        name: 'Sérum Vitamina C',
        price: 89.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.9,
        reviewCount: 267,
        category: 'beleza',
      ),
      Product(
        id: '10',
        name: 'Protetor Solar FPS 50',
        price: 45.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.6,
        reviewCount: 521,
        category: 'beleza',
        isOnPromotion: true,
        discountPercentage: 20,
      ),

      // Suplementos
      Product(
        id: '11',
        name: 'Colágeno Hidrolisado',
        price: 78.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.8,
        reviewCount: 433,
        category: 'suplementos',
      ),
      Product(
        id: '12',
        name: 'Ômega 3 60 cápsulas',
        price: 55.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.7,
        reviewCount: 356,
        category: 'suplementos',
        isOnPromotion: true,
        discountPercentage: 18,
      ),
    ];
  }

  /// Gera categorias mockadas
  List<Category> _generateMockCategories() {
    final categoryMap = <String, int>{};

    for (var product in _allProducts) {
      categoryMap[product.category] = (categoryMap[product.category] ?? 0) + 1;
    }

    return [
      Category(
        id: 'all',
        name: 'Todos',
        icon: Icons.apps_rounded,
        productCount: _allProducts.length,
      ),
      Category(
        id: 'medicamentos',
        name: 'Medicamentos',
        icon: Icons.healing_rounded,
        productCount: categoryMap['medicamentos'] ?? 0,
      ),
      Category(
        id: 'higiene',
        name: 'Higiene',
        icon: Icons.soap_rounded,
        productCount: categoryMap['higiene'] ?? 0,
      ),
      Category(
        id: 'beleza',
        name: 'Beleza',
        icon: Icons.spa_rounded,
        productCount: categoryMap['beleza'] ?? 0,
      ),
      Category(
        id: 'suplementos',
        name: 'Suplementos',
        icon: Icons.favorite_rounded,
        productCount: categoryMap['suplementos'] ?? 0,
      ),
      Category(
        id: 'vitaminas',
        name: 'Vitaminas',
        icon: Icons.energy_savings_leaf_rounded,
        productCount: categoryMap['vitaminas'] ?? 0,
      ),
    ];
  }

  /// Atualiza a query de busca
  void _onSearchChanged() {
    _searchQuery = searchController.text;
    _applyFilters();
  }

  /// Aplica os filtros (categoria + busca)
  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      // Filtro de categoria
      final categoryMatch = _selectedCategoryId.isEmpty ||
          _selectedCategoryId == 'all' ||
          product.category == _selectedCategoryId;

      // Filtro de busca
      final searchMatch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase());

      return categoryMatch && searchMatch;
    }).toList();

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  // ===== MÉTODOS PÚBLICOS =====

  /// Seleciona uma categoria
  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    _applyFilters();
  }

  /// Limpa a busca e os filtros
  void clearFilters() {
    searchController.clear();
    _selectedCategoryId = '';
    _searchQuery = '';
    _applyFilters();
  }

  /// Adiciona um produto ao carrinho (callback)
  void addToCart(Product product) {
    debugPrint(
        'Produto adicionado ao carrinho: ${product.name} - ID: ${product.id}');
    // Implementar lógica de carrinho
  }

  /// Navega para detalhes do produto (callback)
  void viewProductDetail(Product product) {
    debugPrint(
        'Abrindo detalhes do produto: ${product.name} - ID: ${product.id}');
    // Navegar para product_detail_screen
  }

  /// Retorna promoções em destaque
  List<Product> getPromotionalProducts() {
    return _allProducts.where((p) => p.isOnPromotion).toList().take(5).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
