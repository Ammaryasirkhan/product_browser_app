class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final List<String> images;
  final String category;
  final num? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.category,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      images:
          (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      category: json['category'] ?? '',
      rating: json['rating'],
    );
  }
}
