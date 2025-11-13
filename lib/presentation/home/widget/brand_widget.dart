import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../domain/models/brand.dart';
import '../../components/colors/colors.dart';
import '../../components/text/support_widget.dart';
import '../../product/bloc/brand_cubit.dart';
import '../../product/bloc/brand_state.dart';
import '../../product/bloc/product_cubit.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, brandState) {
        // Handle initial state
        if (brandState.status == BrandStatus.initial) {
          return _BrandLoadingWidget(); // Show loading while waiting for data
        }

        if (brandState.status == BrandStatus.loading) {
          return _BrandLoadingWidget();
        }
        if (brandState.status == BrandStatus.failure ||
            brandState.brands.isEmpty) {
          return const SizedBox.shrink();
        }

        return _BrandContent(brands: brandState.brands);
      },
    );
  }
}

class _BrandLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
        color: primaryColor,
        border: Border.all(color: secondaryColor, width: 2),
        boxShadow: [
          BoxShadow(color: accentColor, spreadRadius: 4, blurRadius: 6),
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

class _BrandContent extends StatelessWidget {
  const _BrandContent({required this.brands});

  final List<Brand> brands;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Brands", style: AppText.semiBoldTextFieldStyle()),
        ),

        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(8, 0, 60, 20),

            itemCount: brands.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _AllBrandItem();
              }
              final brand = brands[index - 1];
              return _BrandItem(brand: brand);
            },
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}

class _AllBrandItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedBrandId = context.watch<ProductCubit>().state.selectedBrandId;
    final isSelected = selectedBrandId == null;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: primaryColor,
        selectedColor: secondaryColor,

        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            context.read<ProductCubit>().loadAllProducts();
          }
        },
        label: const Text(
          'All',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
            color: Colors.white,
          ),
        ),
        avatar: const Icon(Icons.apps, size: 20, color: Colors.white),
        showCheckmark: false,
      ),
    );
  }
}

class _BrandItem extends StatelessWidget {
  const _BrandItem({required this.brand});

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    final selectedBrandId = context.watch<ProductCubit>().state.selectedBrandId;
    final isSelected = selectedBrandId == brand.id;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: FilterChip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        selectedColor: secondaryColor,

        side: BorderSide(color: primaryColor, width: 1),

        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            context.read<ProductCubit>().loadProductsByBrandId(brand.id);
          }
        },
        label: Text(
          brand.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
          ),
        ),
        avatar: brand.imageUrl != null && brand.imageUrl!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  brand.imageUrl!,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.branding_watermark, size: 18);
                  },
                ),
              )
            : const Icon(Icons.branding_watermark, size: 18),
        showCheckmark: false,
      ),
    );
  }
}
