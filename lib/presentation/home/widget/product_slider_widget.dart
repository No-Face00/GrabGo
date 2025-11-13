import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../domain/models/product_slider.dart';
import '../../components/colors/colors.dart';
import '../../components/text/support_widget.dart';
import '../../product/bloc/product_slider_cubit.dart';

class ProductSliderWidget extends StatelessWidget {
  const ProductSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSliderCubit, ProductSliderState>(
      builder: (context, sliderState) {
        // Handle initial state
        if (sliderState.status == ProductSliderStatus.initial) {
          return _SliderLoadingWidget(); // Show loading while waiting for data
        }

        if (sliderState.status == ProductSliderStatus.loading) {
          return _SliderLoadingWidget();
        }
        if (sliderState.status == ProductSliderStatus.failure ||
            sliderState.sliders.isEmpty) {
          return const SizedBox.shrink();
        }

        return _SliderContent(sliders: sliderState.sliders);
      },
    );
  }
}

class _SliderLoadingWidget extends StatelessWidget {
  const _SliderLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 220,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [primaryColor, secondaryColor],),
        color: primaryColor,
        border: Border.all(color: secondaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor,
            spreadRadius: 4,
            blurRadius: 6,

          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoadingAnimationWidget.flickr(
            leftDotColor: secondaryColor,
            rightDotColor: primaryColor,

            size: 60,
          ),
        ),
      ),
    );
  }
}

class _SliderContent extends StatelessWidget {
  const _SliderContent({required this.sliders});
  final List<ProductSlider> sliders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            itemCount: sliders.length,
            itemBuilder: (context, index) {
              final slider = sliders[index];
              return _SliderItem(slider: slider);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SliderItem extends StatelessWidget {
  const _SliderItem({required this.slider});
  final ProductSlider slider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: accentColor,
            spreadRadius: 4,
            blurRadius: 6,

          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),

        child: Stack(
          children: [
            if (slider.imageUrl.isNotEmpty)
              Positioned.fill(child: Image.network(
                slider.imageUrl,
                fit: BoxFit.cover,


                errorBuilder: (context, error, stackTrace) {
                  return Container(

                    color: Colors.red,
                    child: Center(
                      child: Row(
                        children: [
                          const Center(
                            child: Icon(Icons.error, color: Colors.black, size: 48),

                          ),
                          Row(
                            children: [
                              Center(
                                child: Text(
                                  'Error loading image',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                  );
                },
              ),
              )
            else Container(
              color: Colors.grey,
              child: const Center(
                child: Icon(Icons.error, color: Colors.black, size: 48),
              ),
            ),

            Positioned.fill(child:
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.1),
                  ],
                ),
              ),

            )
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Discount Badge
                  if (slider.priceLabel != null &&
                      slider.priceLabel!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: textSecondary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        slider.priceLabel!,
                        style: AppText.semiBoldTextFieldStyle()
                        ) ,
                      ),


                  const SizedBox(height: 50),

                  // Title
                  Text(
                    slider.title,
                    style: AppText.WithShadoSemiBoldTextFieldStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Description
                  if (slider.shortDescription != null &&
                      slider.shortDescription!.isNotEmpty)
                    Container(

                      padding: const EdgeInsets.only(right:  8),

                      child: Text(
                        slider.shortDescription!,
                        style: AppText.SmalllightTextFieldStyle(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}
