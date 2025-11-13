import '../../core/network/api_client.dart';
import '../../domain/models/product.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource({required this.apiClient});

  ApiClient apiClient;

  ///fetch products

  Future<List<Product>> fetchProducts() async {
    final result = await apiClient.get('/api/ListProductByBrand/1');
    final data = (result is Map<String, dynamic>) ? result['data'] : result;

    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => Product.fromJson(e))
          .toList();
    }
    if (data is List<dynamic>) {
      return data
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }
    return [];
  }

  ///fetch categories by Brand Id

  Future<List<Product>> fetchProductByBrandId(int brandId) async {
    final result = await apiClient.get('/api/ListProductByBrand/$brandId');
    final data = (result is Map<String, dynamic>) ? result['data'] : result;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => Product.fromJson(e))
          .toList();
    }
    if (data is List<dynamic>) {
      return data
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }
    return [];
  }
}
