import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductApi {
  final Dio dio;
  ProductApi(this.dio);

  Future<List<ProductModel>> fetchProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    final res = await dio.get(
      '/products',
      queryParameters: {'limit': limit, 'skip': skip},
    );

    final List items = res.data['products'] ?? [];
    return items.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<ProductModel> fetchProductDetail(int id) async {
    final res = await dio.get('/products/$id');
    return ProductModel.fromJson(res.data);
  }

  Future<List<ProductModel>> searchProducts(String q) async {
    final res = await dio.get('/products/search', queryParameters: {'q': q});
    final List items = res.data['products'] ?? [];
    return items.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<String>> fetchCategories() async {
    final res = await dio.get('/products/categories');
    final List items = res.data ?? [];
    return items.map((e) => e.toString()).toList();
  }
}
