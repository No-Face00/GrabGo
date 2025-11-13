import 'package:equatable/equatable.dart';

class ProductSlider extends Equatable {
  const ProductSlider({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.shortDescription,
    this.priceLabel,
    this.description,
    this.productId,
  });

  final int id;
  final String title;
  final String imageUrl;
  final String? shortDescription;
  final String? priceLabel;
  final String? description;
  final int? productId;

  factory ProductSlider.fromJson(Map<String, dynamic> json) {
    return ProductSlider(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      imageUrl: json['image'] as String? ?? json['image_url'] as String? ?? '',
      shortDescription: json['short_des'] as String?,
      priceLabel: json['price'] as String?,
      description: json['description'] as String?,
      productId:
      json['product_id'] != null
          ? (json['product_id'] as num).toInt()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image': imageUrl,
    'short_des': shortDescription,
    'price': priceLabel,
    'description': description,
    'product_id': productId,
  };

  @override
  List<Object?> get props => [
    id,
    title,
    imageUrl,
    shortDescription,
    priceLabel,
    description,
    productId,
  ];
}
