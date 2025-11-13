import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabgo/domain/repository/user_repository.dart';

import '../../../domain/repository/brand_repository.dart';
import '../../../domain/repository/product_repository.dart';
import '../../../domain/repository/product_slider_repository.dart';
import '../../components/Appbar/Appbar.dart';
import '../../components/colors/colors.dart';
import '../../components/search_bar/searchbar.dart';
import '../../components/text/support_widget.dart';
import '../../product/bloc/brand_cubit.dart';

import '../../product/bloc/product_cubit.dart';
import '../../product/bloc/product_slider_cubit.dart';

import '../../product/widget/products_widget.dart';
import '../widget/brand_widget.dart';
import '../widget/product_slider_widget.dart';
import '../widget/user_welcome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.brandRepository,
    required this.productRepository,
    required this.productSliderRepository,
    required this.userRepository,
  });

  final BrandRepository brandRepository;
  final ProductRepository productRepository;
  final ProductSliderRepository productSliderRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProductSliderCubit(repository: productSliderRepository)
                ..loadSliders(),
        ),
        BlocProvider(
          create: (_) => BrandCubit(repository: brandRepository)..loadBrands(),
        ),
        BlocProvider(
          create: (_) => ProductCubit(repository: productRepository)..loadAllProducts(),
        ),

        // BlocProvider(create: ,)
        // BlocProvider(create: ,)
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppbarWidget(title: "GrabGo"),

        body: RefreshIndicator(
          color: primaryColor,
          backgroundColor: backgroundColor,
          onRefresh: () async {
            context.read<ProductSliderCubit>().loadSliders();
          },

          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),

              child: Container(
                margin: EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserWelcome(),
                    SizedBox(height: 20),
                    ProductSliderWidget(),
                    Searchbar(hintText: 'Search Product',),
                    SizedBox(height: 10),
                    BrandWidget(),
                    ProductsWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
