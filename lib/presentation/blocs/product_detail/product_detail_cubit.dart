import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository repo;
  ProductDetailCubit(this.repo) : super(ProductDetailLoading());

  Future<void> load(int id) async {
    try {
      emit(ProductDetailLoading());
      final p = await repo.fetchProductDetail(id);
      emit(ProductDetailLoaded(p));
    } catch (e) {
      emit(const ProductDetailError('Failed to load product detail.'));
    }
  }
}
