import 'package:bloc/bloc.dart';
import '../../../core/storage/token_storage.dart';
import '../../../domain/repository/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartRepository, required this.tokenStorage})
      : super(const CartState());

  final CartRepository cartRepository;
  final TokenStorage tokenStorage;

  Future<String?> _getToken() async => tokenStorage.readToken();

  Future<void> loadCart() async {
    final token = await _getToken();
    if (token == null || token.isEmpty) return;
    emit(state.copyWith(status: CartStatus.loading));
    try {
      final items = await cartRepository.getCartList(token: token);
      emit(state.copyWith(status: CartStatus.loaded, items: items));
    } catch (e) {
      emit(
        state.copyWith(status: CartStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> addToCart({
    required int productId,
    required String color,
    required String size,
    required int qty,
  }) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) return;
    // Optimistic: do server call then refresh list
    try {
      await cartRepository.addToCart(
        token: token,
        productId: productId,
        color: color,
        size: size,
        qty: qty,
      );
      await loadCart();
    } catch (e) {
      emit(
        state.copyWith(status: CartStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> deleteItem(int cartId) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) return;
    // Optimistic remove
    final previous = state.items;
    emit(state.copyWith(items: previous.where((e) => e.id != cartId).toList()));
    try {
      await cartRepository.deleteCartItem(token: token, cartId: cartId);
    } catch (_) {
      // Revert on error
      emit(state.copyWith(items: previous));
    }
  }
}
