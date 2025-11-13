import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../domain/models/product_slider.dart';
import '../../../domain/repository/product_slider_repository.dart';

part 'product_slider_state.dart';

class ProductSliderCubit extends Cubit<ProductSliderState> {
  ProductSliderCubit({required this.repository})
    : super(const ProductSliderState.initial());

  final ProductSliderRepository repository;

  Future<void> loadSliders() async {
    emit(state.copyWith(status: ProductSliderStatus.loading));

    try {
      final sliders = await repository.getProductSliders();
      emit(
        state.copyWith(status: ProductSliderStatus.success, sliders: sliders),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductSliderStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
