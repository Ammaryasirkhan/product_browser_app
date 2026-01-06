import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> fetchProducts({int limit = 20, int skip = 0});
  Future<ProductModel> fetchProductDetail(int id);
  Future<List<ProductModel>> searchProducts(String q);
  Future<List<String>> fetchCategories();
}
