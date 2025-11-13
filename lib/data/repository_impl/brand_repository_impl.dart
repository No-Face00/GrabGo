import 'package:grabgo/data/remote_data_source/brand_remote_data_source.dart';
import 'package:grabgo/domain/models/brand.dart';

import '../../domain/repository/brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {

  BrandRemoteDataSource remoteDataSource;

  BrandRepositoryImpl({required this.remoteDataSource});

@override
  Future<List<Brand>> getBrands() {

    return remoteDataSource.fetchBrands();
  }
}