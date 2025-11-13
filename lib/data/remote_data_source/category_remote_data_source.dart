import 'package:grabgo/domain/models/categorys.dart';

import '../../core/network/api_client.dart';

class CategoryRemoteDataSource {
  CategoryRemoteDataSource({required this.apiClient});

  ApiClient apiClient;

  ///fetch categories

  Future<List<Category>> fetchCategories() async {
    final result = await apiClient.get('/api/CategoryList');
    final data = (result is Map<String, dynamic>) ? result['data'] : result;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => Category.fromJson(e))
          .toList();
    }
    if (data is List<dynamic>) {
      return data
          .map((e) => Category.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }
    return [];
  }
}
