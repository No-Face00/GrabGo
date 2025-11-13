
import 'package:grabgo/core/network/api_client.dart';
import 'package:grabgo/domain/models/brand.dart';

class BrandRemoteDataSource {

  BrandRemoteDataSource({required this.apiClient});

  ApiClient apiClient;

  ///fetch brands

  Future<List<Brand>> fetchBrands() async {
    final result = await apiClient.get('/api/BrandList');
    final data = (result is Map<String, dynamic>) ? result['data'] : result;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => Brand.fromJson(e))
          .toList();
    }
    if (data is List<dynamic>) {
      return data
          .map((e) => Brand.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }
    return [];
  }
}


