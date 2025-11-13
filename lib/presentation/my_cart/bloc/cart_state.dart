import 'package:equatable/equatable.dart';

import '../../../domain/models/cart_item.dart';

enum CartStatus { idle, loading, loaded, error }

class CartState extends Equatable {
  const CartState({
    this.status = CartStatus.idle,
    this.items = const [],
    this.errorMessage,
  });

  final CartStatus status;
  final List<CartItem> items;
  final String? errorMessage;

  double get totalPrice => items.fold(0, (sum, e) => sum + e.price);

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? items,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage];
}
