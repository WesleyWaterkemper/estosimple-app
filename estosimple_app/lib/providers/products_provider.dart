import 'package:estosimple_app/models/product.dart';
import 'package:estosimple_app/services/products_service.dart';
import 'package:flutter/foundation.dart';

class ProductsProvider extends ChangeNotifier{
  final ProductsService _productsService;

  ProductsProvider(this._productsService);
 
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Controle de erro
  String? _error;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productsService.getProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newProduct = await _productsService.createProduct(product);

      _products.add(newProduct);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedProduct = await _productsService.updateProduct(product);

      final index = _products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        _products[index] = updatedProduct;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeProduct(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _productsService.deleteProduct(id);

      _products.removeWhere((p) => p.id == id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}