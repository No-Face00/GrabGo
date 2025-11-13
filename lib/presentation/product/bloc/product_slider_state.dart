part of 'product_slider_cubit.dart';

enum ProductSliderStatus { initial, loading, success, failure }

class ProductSliderState extends Equatable {
  const ProductSliderState({
    required this.status,
    required this.sliders,
    this.errorMessage,
  });

  const ProductSliderState.initial()
    : status = ProductSliderStatus.initial,
      sliders = const [],
      errorMessage = null;

  final ProductSliderStatus status;
  final List<ProductSlider> sliders;
  final String? errorMessage;

  ProductSliderState copyWith({
    ProductSliderStatus? status,
    List<ProductSlider>? sliders,
    String? errorMessage,
  }) {
    return ProductSliderState(
      status: status ?? this.status,
      sliders: sliders ?? this.sliders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, sliders, errorMessage];
}
