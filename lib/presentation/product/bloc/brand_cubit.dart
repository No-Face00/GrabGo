import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/brand.dart';
import '../../../domain/repository/brand_repository.dart';
import 'brand_state.dart';



class BrandCubit extends Cubit<BrandState> {
  BrandCubit({required this.repository} ) :super(BrandState.initial());

   final BrandRepository repository;

   Future<void> loadBrands() async {
     emit(state.copyWith(status: BrandStatus.loading));
     try {
       final brands = await repository.getBrands();
       emit(state.copyWith(status: BrandStatus.success, brands: brands));
     } catch (e) {
       emit(state.copyWith(status: BrandStatus.failure, errorMessage: e.toString()));
     }
   }


}
