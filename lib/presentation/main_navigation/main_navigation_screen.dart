import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grabgo/domain/repository/brand_repository.dart';
import 'package:grabgo/domain/repository/user_repository.dart';
import 'package:grabgo/presentation/home/screen/home_screen.dart';

import '../../domain/repository/category_repository.dart';
import '../../domain/repository/product_repository.dart';
import '../../domain/repository/product_slider_repository.dart';
import '../categories/screen/categories_screen.dart';
import '../my_cart/screen/my_cart_screen.dart';

import '../components/colors/colors.dart';
import '../user/screen/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    required this.brandRepository,
    required this.productRepository,
    required this.productSliderRepository,
    required this.categoryRepository,
    required this.userRepository,
  });

  final BrandRepository brandRepository;
  final ProductRepository productRepository;
  final ProductSliderRepository productSliderRepository;
  final CategoryRepository categoryRepository;
  final UserRepository userRepository;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late List<Widget> pages;
  late HomeScreen homeScreen;
  late CategoriesScreen categoriesScreen;
  late MyCartScreen myCartScreen;
  late ProfileScreen profileScreen;
  int currentIndex = 0;

  @override
  void initState() {
    homeScreen = HomeScreen(
      brandRepository: widget.brandRepository,
      productRepository: widget.productRepository,
      productSliderRepository: widget.productSliderRepository,
      userRepository: widget.userRepository,
    );
    categoriesScreen = CategoriesScreen(
      categoryRepository: widget.categoryRepository,
    );
    myCartScreen = MyCartScreen();
    profileScreen = ProfileScreen();
    pages = [homeScreen, categoriesScreen, myCartScreen, profileScreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: backgroundColor,
        color: primaryColor,
        animationDuration: Duration(milliseconds: 500),
        index: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.category_outlined, color: Colors.white),
          Icon(Icons.shopping_cart_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
