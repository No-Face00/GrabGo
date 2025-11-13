import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/product.dart';
import '../../../domain/repository/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.repository}) : super(ProductState.initial());

  final ProductRepository repository;

  Future<void> loadProductsByBrandId(int brandId) async {
    emit(
      state.copyWith(status: ProductStatus.loading, selectedBrandId: brandId),
    );

    try {
      final products = await repository.getProductsByBrands(brandId);
      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: products,
          selectedBrandId: brandId,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loadAllProducts() async {
    emit(state.copyWith(status: ProductStatus.loading, selectedBrandId: null));

    try {
      final products = await repository.getProductsByBrands(1);
      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: products,
          selectedBrandId: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
