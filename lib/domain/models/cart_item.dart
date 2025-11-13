
import 'package:grabgo/domain/models/product.dart';

class CartItem {
  CartItem({
    required this.id,
    required this.productId,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
    required this.product,
  });

  final int id;
  final int productId;
  final String color;
  final String size;
  final int quantity;
  final double price;
  final Product product;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: (json['id'] ?? 0) as int,
      productId: (json['product_id'] ?? 0) as int,
      color: (json['color'] ?? '') as String,
      size: (json['size'] ?? '') as String,
      quantity: int.tryParse('${json['qty'] ?? 0}') ?? 0,
      price: double.tryParse('${json['price'] ?? 0}')?.toDouble() ?? 0,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }
}
