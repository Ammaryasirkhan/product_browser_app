import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/price_ext.dart';
import '../blocs/product_detail/product_detail_cubit.dart';
import '../blocs/product_detail/product_detail_state.dart';
import '../widgets/app_error_view.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<ProductDetailCubit>()..load(productId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Detail')),
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductDetailError) {
              return AppErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<ProductDetailCubit>().load(productId),
              );
            }

            if (state is ProductDetailLoaded) {
              final p = state.product;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: (p.images.isNotEmpty
                          ? p.images.first
                          : p.thumbnail),
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const SizedBox(
                        height: 220,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (_, __, ___) => const SizedBox(
                        height: 220,
                        child: Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(p.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    p.price.asMoney(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(p.description),
                  const SizedBox(height: 12),
                  Text('Category: ${p.category}'),
                  const SizedBox(height: 8),
                  if (p.rating != null) Text('Rating: ${p.rating}'),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
