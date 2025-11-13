
import '../../core/network/api_client.dart';
import '../../domain/models/product_slider.dart';

/// Remote data source that fetches product sliders from the ecommerce API.
class ProductSliderRemoteDataSource {
  ProductSliderRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  /// Fetch a list of product sliders.
  Future<List<ProductSlider>> fetchProductSliders() async {
    final result = await apiClient.get('/api/ListProductSlider');
    final data = (result is Map<String, dynamic>) ? result['data'] : result;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => ProductSlider.fromJson(e))
          .toList();
    }
    if (data is List<dynamic>) {
      return data
          .map(
            (e) => ProductSlider.fromJson(Map<String, dynamic>.from(e as Map)),
      )
          .toList();
    }
    return [];
  }
}
