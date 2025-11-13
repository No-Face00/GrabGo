
import 'package:grabgo/domain/models/categorys.dart';

abstract class CategoryRepository {

  Future<List<Category>> getCategories();
}