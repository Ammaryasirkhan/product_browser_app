extension PriceFormatting on num {
  String asMoney() => '\$${toDouble().toStringAsFixed(2)}';
}
