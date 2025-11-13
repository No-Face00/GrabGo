import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabgo/presentation/components/text/support_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../domain/models/product.dart';
import '../../components/colors/colors.dart';
import '../../my_cart/bloc/cart_cubit.dart';
import '../bloc/product_cubit.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({super.key});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductsHeader(
          isGridView: _isGridView,
          onViewToggle: (isGrid) {
            setState(() {
              _isGridView = isGrid;
            });
          },
        ),
        const SizedBox(height: 12),
        _ProductsContent(isGridView: _isGridView),
      ],
    );
  }
}

class _ProductsHeader extends StatelessWidget {
  const _ProductsHeader({required this.isGridView, required this.onViewToggle});

  final bool isGridView;
  final ValueChanged<bool> onViewToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Products', style: AppText.semiBoldTextFieldStyle()),
          Row(
            children: [
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, productState) {
                  if (productState.selectedBrandId != null) {
                    return TextButton(
                      onPressed: () {
                        context.read<ProductCubit>().loadAllProducts();
                      },
                      child: const Text(
                        'Show All',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(width: 8),
              _ViewToggleButtons(
                isGridView: isGridView,
                onViewToggle: onViewToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewToggleButtons extends StatelessWidget {
  const _ViewToggleButtons({
    required this.isGridView,
    required this.onViewToggle,
  });

  final bool isGridView;
  final ValueChanged<bool> onViewToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleButton(
            icon: Icons.grid_view,
            isSelected: isGridView,
            onTap: () => onViewToggle(true),
          ),
          _ToggleButton(
            icon: Icons.list,
            isSelected: !isGridView,
            onTap: () => onViewToggle(false),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected
              ? Colors.white
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _ProductsContent extends StatelessWidget {
  const _ProductsContent({required this.isGridView});

  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState.status == ProductStatus.loading) {
          return const _ProductsLoadingWidget();
        }

        if (productState.status == ProductStatus.failure) {
          return _ProductsErrorWidget(
            errorMessage: productState.errorMessage,
            onRetry: () =>
                context.read<ProductCubit>().loadProductsByBrandId(1),
          );
        }

        if (productState.products.isEmpty) {
          return const _ProductsEmptyWidget();
        }

        return _ProductsList(
          products: productState.products,
          isGridView: isGridView,
        );
      },
    );
  }
}

class _ProductsLoadingWidget extends StatelessWidget {
  const _ProductsLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      child: Center(
        child: LoadingAnimationWidget.flickr(
          leftDotColor: secondaryColor,
          rightDotColor: primaryColor,

          size: 60,
        ),
      ),
    );
  }
}

class _ProductsErrorWidget extends StatelessWidget {
  const _ProductsErrorWidget({
    required this.errorMessage,
    required this.onRetry,
  });

  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: ${errorMessage ?? 'Something went wrong'}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _ProductsEmptyWidget extends StatelessWidget {
  const _ProductsEmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: textPrimary),
            const SizedBox(height: 16),
            Text('No products found', style: AppText.semiBoldTextFieldStyle()),

            const SizedBox(height: 8),
            Text(
              'Try selecting a different brand',
              style: TextStyle(color: textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({required this.products, required this.isGridView});

  final List<Product> products;
  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      return _ProductsGridView(products: products);
    } else {
      return _ProductsListView(products: products);
    }
  }
}

class _ProductsGridView extends StatelessWidget {
  const _ProductsGridView({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),

      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductGridCard(product: product);
      },
    );
  }
}

class _ProductsListView extends StatelessWidget {
  const _ProductsListView({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ProductListCard(product: product),
        );
      },
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  const _ProductGridCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,

      shadowColor: secondaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // TODO: Navigate to product details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Badge
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    child: product.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceVariant,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: Icon(
                              Icons.image,
                              size: 40,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),

                  // Wishlist Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.shadow.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          // TODO: Add to wishlist
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Info
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // Category Badge
                    if (product.categoryDetail?.name != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.categoryDetail!.name,
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),

                    if (product.categoryDetail?.name != null)
                      const SizedBox(height: 6),

                    // Product Title
                    Text(
                      style: TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        fontFamily: 'Outfit',
                      ),

                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Price and Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Left side → Price on top, Rating below
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // PRICE
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 4),

                            // RATING
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Right side → Add To Cart button
                        Flexible(
                          child: SizedBox(
                            height: 30,
                            child: _AddToCartButton(productId: product.id),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductListCard extends StatelessWidget {
  const _ProductListCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 4,

      shadowColor: secondaryColor,

      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // TODO: Navigate to product details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Product Image with Badge
              Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: secondaryColor,
                    ),
                    child: product.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: secondaryColor,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 30,
                                    color: primaryColor,
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            color: secondaryColor,
                            child: Icon(
                              Icons.image,
                              size: 30,
                              color: primaryColor,
                            ),
                          ),
                  ),

                  // Wishlist Button
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      height: 30,
                      width: 30,

                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.shadow.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          // TODO: Add to wishlist
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: textPrimary,
                        ),
                        padding: const EdgeInsets.all(6),
                        constraints: const BoxConstraints(
                          minWidth: 28,
                          minHeight: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    if (product.categoryDetail?.name != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.categoryDetail!.name,
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),

                    if (product.categoryDetail?.name != null)
                      const SizedBox(height: 8),

                    // Product Title
                    Text(
                      product.title,
                      style: TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        fontFamily: 'Outfit',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Price and Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // LEFT COLUMN → Price on top, rating below
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // PRICE
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                fontFamily: 'Outfit',
                              ),
                            ),

                            const SizedBox(height: 4),

                            // RATING
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // RIGHT SIDE → Add button
                        _AddToCartButton(productId: product.id),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        // Using default color/size and qty=1 as this app has no variants selector yet
        context.read<CartCubit>().addToCart(
          productId: productId,
          color: 'Red',
          size: 'X',
          qty: 1,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Added to cart')));
      },
      style: FilledButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size(60, 32),

        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      icon: Icon(Icons.add_shopping_cart, size: 14, color: Colors.white),
      label: const Text(
        'Add',
        style: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
    );
  }
}
