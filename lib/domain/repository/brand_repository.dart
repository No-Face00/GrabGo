import 'package:grabgo/domain/models/brand.dart';

abstract class BrandRepository {

 Future<List<Brand>> getBrands();
}