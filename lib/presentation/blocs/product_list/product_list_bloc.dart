import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';
import 'package:rxdart/rxdart.dart';


class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository repo;
  List<dynamic> _cached = []; // store last loaded list

  ProductListBloc(this.repo) : super(ProductListInitial()) {
    on<FetchProducts>(_onFetch);
    on<RetryFetchProducts>(_onFetch);
    on<SearchProducts>(
      _onSearch,
      transformer: _debounce(const Duration(milliseconds: 450)),
    );
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onFetch(
    ProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    try {
      emit(ProductListLoading());
      final products = await repo.fetchProducts(limit: 30, skip: 0);
      _cached = products;
      emit(ProductListLoaded(products: products, isSearching: false));
    } catch (e) {
      emit(
        const ProductListError('Failed to load products. Please try again.'),
      );
    }
  }

  Future<void> _onSearch(
    SearchProducts event,
    Emitter<ProductListState> emit,
  ) async {
    final q = event.query.trim();
    if (q.isEmpty) {
      add(ClearSearch());
      return;
    }

    try {
      emit(ProductListLoading());
      final products = await repo.searchProducts(q);
      emit(ProductListLoaded(products: products, isSearching: true));
    } catch (e) {
      emit(const ProductListError('Search failed. Please try again.'));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<ProductListState> emit) {
    if (_cached.isNotEmpty) {
      emit(ProductListLoaded(products: _cached.cast(), isSearching: false));
    } else {
      add(FetchProducts());
    }
  }

  EventTransformer<T> _debounce<T>(Duration duration) {
    return (events, mapper) {
      return events.debounceTime(duration).switchMap(mapper);
    };
  }

}
