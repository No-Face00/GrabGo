
import '../../core/network/api_client.dart';
import '../../domain/models/cart_item.dart';

class CartRemoteDataSource {
  CartRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  Future<List<CartItem>> fetchCartList({required String token}) async {
    final json =
    await apiClient.get('/api/CartList', headers: {'token': token})
    as Map<String, dynamic>;
    final List<dynamic> list = json['data'] as List<dynamic>;
    return list
        .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> addToCart({
    required String token,
    required int productId,
    required String color,
    required String size,
    required int qty,
  }) async {
    final json =
    await apiClient.post(
      '/api/CreateCartList',
      headers: {'token': token},
      body: {
        'product_id': productId,
        'color': color,
        'size': size,
        'qty': qty,
      },
    )
    as Map<String, dynamic>;
    // We don't need to return anything; we'll refresh the cart list after this call
    final _ = json['data'];
  }

  Future<void> deleteCartItem({
    required String token,
    required int cartId,
  }) async {
    await apiClient.get(
      '/api/DeleteCartList/$cartId',
      headers: {'token': token},
    );
  }
}
