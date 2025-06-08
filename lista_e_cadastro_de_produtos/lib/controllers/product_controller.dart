import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../models/product.dart';

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();

  final List<String> _categories = [];
  List<String> get categories => _categories;

  final List<Product> _allProducts = [];
  final List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      final fetched = await _service.getCategories();
      _categories
        ..clear()
        ..add('Todos') // Adiciona a opção "Todos"
        ..addAll(fetched);
    } catch (e) {
      _categories
        ..clear()
        ..add('Todos');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final produtos = await _service.getProducts();
      _allProducts
        ..clear()
        ..addAll(produtos);
      _applyFilter();
    } catch (e) {
      _allProducts.clear();
      _products.clear();
    }
    _isLoading = false;
    notifyListeners();
  }

  void setSelectedCategory(String? value) {
    _selectedCategory = value;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_selectedCategory == null ||
        _selectedCategory == 'Todos' ||
        _selectedCategory!.isEmpty) {
      _products
        ..clear()
        ..addAll(_allProducts);
    } else {
      _products
        ..clear()
        ..addAll(_allProducts.where((p) => p.categoria == _selectedCategory));
    }
  }

  Future<void> addProduct(Product product) async {
    await _service.addProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(int index, Product product) async {
    await _service.updateProduct(index, product);
    await fetchProducts();
  }

  Future<void> deleteProduct(int index) async {
    await _service.deleteProduct(index);
    await fetchProducts();
  }
}
