import 'package:grabgo/domain/models/product.dart';

abstract class ProductRepository {

  Future<List<Product>> getProductsByBrands(int brandId);
}