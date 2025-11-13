import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabgo/data/repository_impl/cart_repository_impl.dart';
import 'package:grabgo/domain/repository/cart_repository.dart';
import 'package:grabgo/presentation/my_cart/bloc/cart_cubit.dart';
import 'package:grabgo/presentation/user/bloc/user_cubit.dart';
import 'package:grabgo/presentation/splash/splash_screen.dart';

import 'core/network/api_client.dart';
import 'core/storage/token_storage.dart';
import 'data/remote_data_source/auth_remote_data_source.dart';
import 'data/remote_data_source/brand_remote_data_source.dart';
import 'data/remote_data_source/cart_remote_data_source.dart';
import 'data/remote_data_source/category_remote_data_source.dart';
import 'data/remote_data_source/product_remote_data_source.dart';
import 'data/remote_data_source/product_slider_remote_data_source.dart';
import 'data/remote_data_source/user_remote_data_source.dart';
import 'data/repository_impl/auth_repository_impl.dart';
import 'data/repository_impl/brand_repository_impl.dart';
import 'data/repository_impl/category_repository_impl.dart';
import 'data/repository_impl/product_repository_impl.dart';
import 'data/repository_impl/product_slider_repository_impl.dart';
import 'data/repository_impl/user_repository_impl.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/repository/user_repository.dart';

void main() {
  runApp(const GrabGo());
}

class GrabGo extends StatelessWidget {
  const GrabGo({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient(baseUrl: 'https://ecommerce-api.codesilicon.com');

    // Initialize data sources
    final brandRemoteDataSource = BrandRemoteDataSource(apiClient: apiClient);
    final productRemoteDataSource = ProductRemoteDataSource(apiClient: apiClient);
    final productSliderRemoteDataSource = ProductSliderRemoteDataSource(apiClient: apiClient);
    final categoryRemoteDataSource = CategoryRemoteDataSource(apiClient: apiClient);
    final authRemoteDataSource = AuthRemoteDataSource(apiClient: apiClient);
    final userRemoteDataSource = UserRemoteDataSource(apiClient: apiClient);
    final cartRemoteDataSource = CartRemoteDataSource(apiClient: apiClient);

    // Initialize repositories
    final brandRepository = BrandRepositoryImpl(remoteDataSource: brandRemoteDataSource);
    final productRepository = ProductRepositoryImpl(remoteDataSource: productRemoteDataSource);
    final productSliderRepository =
    ProductSliderRepositoryImpl(remoteDataSource: productSliderRemoteDataSource);
    final categoryRepository = CategoryRepositoryImpl(remoteDataSource: categoryRemoteDataSource);
    final AuthRepository authRepository =
    AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
    final UserRepository userRepository =
    UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
    final CartRepository cartRepository =
    CartRepositoryImpl(remoteDataSource: cartRemoteDataSource);
    final tokenStorage = TokenStorage();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(
            authRepository: authRepository,
            userRepository: userRepository,
            tokenStorage: tokenStorage,
          )..initialize(),
        ),
        BlocProvider(
          create: (_) => CartCubit(
            cartRepository: cartRepository,
            tokenStorage: tokenStorage,
          )..loadCart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "GrabGo",
        home: SplashScreen(
          brandRepository: brandRepository,
          productRepository: productRepository,
          productSliderRepository: productSliderRepository,
          categoryRepository: categoryRepository,
          userRepository: userRepository,
        ),
      ),
    );
  }
}