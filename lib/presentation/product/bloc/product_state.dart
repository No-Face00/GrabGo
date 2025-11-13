part of 'product_cubit.dart';

enum ProductStatus { initial, loading, success, failure }

 class ProductState extends Equatable {
  const ProductState(

      {required this.status,
      required this.products,
      this.errorMessage,
      this.selectedBrandId,
      }
      );

  final ProductStatus status;
  final List<Product> products;
  final String? errorMessage;
  final int? selectedBrandId;

  const ProductState.initial()
      : status = ProductStatus.initial,
        products = const [],
        errorMessage = null,
        selectedBrandId = null;

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
    int? selectedBrandId,
  })
  {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
    );
  }





  @override
  // TODO: implement props
  List<Object?> get props => [status, products, errorMessage, selectedBrandId];

}


