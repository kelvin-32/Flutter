import '../models/product.dart';

class ProductService {
  final List<String> _categories = ['Eletrônicos', 'Roupas', 'Livros'];
  final List<Product> _products = [];

  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<String>.from(_categories);
  }

  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<Product>.from(_products);
  }

  Future<void> addProduct(Product product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _products.add(product);
  }

  Future<void> updateProduct(int index, Product product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _products[index] = product;
  }

  Future<void> deleteProduct(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _products.removeAt(index);
  }
}
