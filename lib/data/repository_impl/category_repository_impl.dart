
import 'package:grabgo/data/remote_data_source/category_remote_data_source.dart';
import 'package:grabgo/domain/models/categorys.dart';

import '../../domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {

  CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Category>> getCategories() {
    return remoteDataSource.fetchCategories();
  }



}