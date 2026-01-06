import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';
import '../sources/product_api.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi api;
  ProductRepositoryImpl(this.api);

  @override
  Future<List<ProductModel>> fetchProducts({int limit = 20, int skip = 0}) {
    return api.fetchProducts(limit: limit, skip: skip);
  }

  @override
  Future<ProductModel> fetchProductDetail(int id) => api.fetchProductDetail(id);

  @override
  Future<List<ProductModel>> searchProducts(String q) => api.searchProducts(q);

  @override
  Future<List<String>> fetchCategories() => api.fetchCategories();
}
