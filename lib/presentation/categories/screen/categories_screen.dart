import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../domain/repository/category_repository.dart';
import '../../components/Appbar/Appbar.dart';
import '../../components/colors/colors.dart';
import '../../components/text/support_widget.dart';
import '../bloc/category_cubit.dart';

class CategoriesScreen extends StatelessWidget {

  const CategoriesScreen({
    super.key,
    required this.categoryRepository,
  });

  final CategoryRepository categoryRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(repository: categoryRepository)..loadCategories(),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppbarWidget(title: "Category"),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          switch (state.status) {
            case CategoryStatus.initial:
              return const SizedBox.shrink();

            case CategoryStatus.loading:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: secondaryColor,
                    rightDotColor: primaryColor,

                    size: 60,
                  ),
                ),
              );

            case CategoryStatus.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load categories',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage ?? 'Unknown error',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        context.read<CategoryCubit>().loadCategories();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case CategoryStatus.success:
              if (state.categories.isEmpty) {
                return const Center(
                  child: Text('No categories available'),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return Card(
                    surfaceTintColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: secondaryColor,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // TODO: Navigate to product details
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                              ),
                              child: category.imageUrl != null && category.imageUrl!.isNotEmpty
                                  ? Image.network(
                                category.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.category,
                                    size: 48,
                                    color: Colors.grey,
                                  );
                                },
                              )
                                  : const Icon(
                                Icons.category,
                                size: 48,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category.name,
                                style: AppText.semiBoldTextFieldStyle(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
