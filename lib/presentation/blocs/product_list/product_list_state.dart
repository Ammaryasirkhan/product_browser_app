import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ProductModel> products;
  final bool isSearching;
  const ProductListLoaded({required this.products, required this.isSearching});

  @override
  List<Object?> get props => [products, isSearching];
}

class ProductListError extends ProductListState {
  final String message;
  const ProductListError(this.message);

  @override
  List<Object?> get props => [message];
}
