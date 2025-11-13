import 'package:grabgo/data/remote_data_source/product_remote_data_source.dart';
import 'package:grabgo/domain/models/product.dart';

import '../../domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProductsByBrands(int brandId) {
    return remoteDataSource.fetchProductByBrandId(brandId);
  }
}
