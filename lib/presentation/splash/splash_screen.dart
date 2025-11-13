import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grabgo/presentation/main_navigation/main_navigation_screen.dart';
import 'package:grabgo/domain/repository/brand_repository.dart';
import 'package:grabgo/domain/repository/category_repository.dart';
import 'package:grabgo/domain/repository/product_repository.dart';
import 'package:grabgo/domain/repository/product_slider_repository.dart';
import 'package:grabgo/domain/repository/user_repository.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../components/colors/colors.dart';

class SplashScreen extends StatefulWidget {
  final BrandRepository brandRepository;
  final ProductRepository productRepository;
  final ProductSliderRepository productSliderRepository;
  final CategoryRepository categoryRepository;
  final UserRepository userRepository;

  const SplashScreen({
    super.key,
    required this.brandRepository,
    required this.productRepository,
    required this.productSliderRepository,
    required this.categoryRepository,
    required this.userRepository,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationScreen(
            userRepository: widget.userRepository,
            brandRepository: widget.brandRepository,
            productRepository: widget.productRepository,
            productSliderRepository: widget.productSliderRepository,
            categoryRepository: widget.categoryRepository,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(Icons.shopping_bag, size: 90, color: Colors.white),
            SizedBox(height: 18),
            Text(
              'GrabGo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: LoadingAnimationWidget.inkDrop(
                    size: 40,
                    color: Colors.white,

                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}