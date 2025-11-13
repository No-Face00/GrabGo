
import '../models/product_slider.dart';

abstract class ProductSliderRepository {
  Future<List<ProductSlider>> getProductSliders();
}
