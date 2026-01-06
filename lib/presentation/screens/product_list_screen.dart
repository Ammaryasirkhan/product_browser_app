import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_list/product_list_bloc.dart';
import '../blocs/product_list/product_list_event.dart';
import '../blocs/product_list/product_list_state.dart';
import '../widgets/app_error_view.dart';
import '../widgets/product_tile.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductListBloc>().add(FetchProducts());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductListBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (v) => bloc.add(SearchProducts(v)),
                decoration: InputDecoration(
                  hintText: 'Search by title...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchCtrl.clear();
                            bloc.add(ClearSearch());
                            setState(() {});
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductListBloc, ProductListState>(
                builder: (context, state) {
                  if (state is ProductListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductListError) {
                    return AppErrorView(
                      message: state.message,
                      onRetry: () => bloc.add(RetryFetchProducts()),
                    );
                  }

                  if (state is ProductListLoaded) {
                    if (state.products.isEmpty) {
                      return const Center(child: Text('No products found.'));
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isWide = constraints.maxWidth >= 600;

                        return RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(FetchProducts());
                          },
                          child: isWide
                              ? GridView.builder(
                                  padding: const EdgeInsets.all(8),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            constraints.maxWidth >= 900 ? 3 : 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio: 3.5,
                                      ),
                                  itemCount: state.products.length,
                                  itemBuilder: (context, i) {
                                    final p = state.products[i];
                                    return Material(
                                      borderRadius: BorderRadius.circular(12),
                                      clipBehavior: Clip.antiAlias,
                                      child: ProductTile(
                                        product: p,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProductDetailScreen(
                                                    productId: p.id,
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                )
                              : ListView.separated(
                                  itemCount: state.products.length,
                                  separatorBuilder: (_, _) =>
                                      const Divider(height: 1),
                                  itemBuilder: (context, i) {
                                    final p = state.products[i];
                                    return ProductTile(
                                      product: p,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ProductDetailScreen(
                                              productId: p.id,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
