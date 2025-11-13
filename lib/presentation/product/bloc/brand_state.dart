




import '../../../domain/models/brand.dart';
import 'package:equatable/equatable.dart';


enum BrandStatus { initial, loading, success, failure }

class BrandState extends Equatable {
  const BrandState({
    required this.status,
    required this.brands,
    this.errorMessage,
  });


  const BrandState.initial()
    :status = BrandStatus.initial,
     brands = const [],
     errorMessage = null;

  final BrandStatus status;
  final List<Brand> brands;
  final String? errorMessage;

  BrandState copyWith({
    BrandStatus? status,
    List<Brand>? brands,
    String? errorMessage,
  })
  {
    return BrandState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }



  @override
  List<Object?> get props => [status, brands, errorMessage];
}
