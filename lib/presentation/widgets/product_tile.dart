import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/price_ext.dart';
import '../../../data/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: product.thumbnail,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          placeholder: (_, _) => const SizedBox(
            width: 56,
            height: 56,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          errorWidget: (_, _, _) => const Icon(Icons.broken_image),
        ),
      ),
      title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(product.price.asMoney()),
      onTap: onTap,
    );
  }
}
