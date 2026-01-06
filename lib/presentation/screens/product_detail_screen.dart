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
        body: SafeArea(
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
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

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isWide = constraints.maxWidth >= 700;

                    final image = ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: p.images.isNotEmpty
                            ? p.images.first
                            : p.thumbnail,
                        height: isWide ? 320 : 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => SizedBox(
                          height: isWide ? 320 : 220,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (_, _, _) => SizedBox(
                          height: isWide ? 320 : 220,
                          child: const Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    );

                    final details = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.price.asMoney(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(p.description),
                        const SizedBox(height: 16),
                        Text('Category: ${p.category}'),
                        if (p.rating != null) ...[
                          const SizedBox(height: 8),
                          Text('Rating: ${p.rating}'),
                        ],
                      ],
                    );

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 5, child: image),
                                const SizedBox(width: 24),
                                Expanded(flex: 6, child: details),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                image,
                                const SizedBox(height: 16),
                                details,
                              ],
                            ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
