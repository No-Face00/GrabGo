
import '../../domain/models/cart_item.dart';
import '../../domain/repository/cart_repository.dart';
import '../remote_data_source/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required this.remoteDataSource});

  final CartRemoteDataSource remoteDataSource;

  @override
  Future<List<CartItem>> getCartList({required String token}) {
    return remoteDataSource.fetchCartList(token: token);
  }

  @override
  Future<void> addToCart({
    required String token,
    required int productId,
    required String color,
    required String size,
    required int qty,
  }) async {
    await remoteDataSource.addToCart(
      token: token,
      productId: productId,
      color: color,
      size: size,
      qty: qty,
    );
  }

  @override
  Future<void> deleteCartItem({required String token, required int cartId}) {
    return remoteDataSource.deleteCartItem(token: token, cartId: cartId);
  }
}
