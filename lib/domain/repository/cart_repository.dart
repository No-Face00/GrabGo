
import '../models/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartList({required String token});

  Future<void> addToCart({
    required String token,
    required int productId,
    required String color,
    required String size,
    required int qty,
  });

  Future<void> deleteCartItem({required String token, required int cartId});
}
