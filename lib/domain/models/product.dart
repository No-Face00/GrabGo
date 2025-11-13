import 'package:equatable/equatable.dart';


import 'brand.dart';
import 'categorys.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    this.shortDescription,
    this.remark,
    required this.imageUrl,
    this.brand,
    this.categoryDetail,
  });

  final int id;
  final String title;
  final num price;
  final String? shortDescription;
  final String? remark;

  final String imageUrl;
  final Brand? brand;
  final Category? categoryDetail;

  factory Product.fromJson(Map<String, dynamic> json) {
    // Some endpoints wrap categories fields and include nested brand/category
    final brandMap = json['brand'] as Map<String, dynamic>?;
    final categoryMap = json['category'] as Map<String, dynamic>?;
    final dynamic priceRaw = json['price'];
    final num parsedPrice =
    priceRaw is num
        ? priceRaw
        : num.tryParse(priceRaw?.toString() ?? '') ?? 0;
    return Product(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      price: parsedPrice,
      shortDescription: json['short_des'] as String?,
      remark: json['remark'] as String?,

      imageUrl: json['image'] as String? ?? '',
      brand: brandMap != null ? Brand.fromJson(brandMap) : null,
      categoryDetail:
      categoryMap != null ? Category.fromJson(categoryMap) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'short_des': shortDescription,
    'remark': remark,

    'image': imageUrl,
    'brand': brand?.toJson(),
    'category': categoryDetail?.toJson(),
  };

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    shortDescription,
    remark,

    imageUrl,
    brand,
    categoryDetail,
  ];
}
