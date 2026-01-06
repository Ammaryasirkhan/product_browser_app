import 'package:flutter/material.dart';
import 'package:product_browser_app/core_app.dart';
import 'core/dio/dio_client.dart';
import 'data/sources/product_api.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';


void main() {
  final dioClient = DioClient();
  final api = ProductApi(dioClient.dio);
  final ProductRepository repo = ProductRepositoryImpl(api);

  runApp(MyApp(repo: repo));
}
