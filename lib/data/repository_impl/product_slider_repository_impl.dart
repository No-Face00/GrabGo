
import '../../domain/models/product_slider.dart';
import '../../domain/repository/product_slider_repository.dart';
import '../remote_data_source/product_slider_remote_data_source.dart';

class ProductSliderRepositoryImpl implements ProductSliderRepository {
  ProductSliderRepositoryImpl({required this.remoteDataSource});

  final ProductSliderRemoteDataSource remoteDataSource;

  @override
  Future<List<ProductSlider>> getProductSliders() {
    return remoteDataSource.fetchProductSliders();
  }
}
