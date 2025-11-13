
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/Appbar/Appbar.dart';
import '../../components/colors/colors.dart';
import '../bloc/cart_cubit.dart';
import '../bloc/cart_state.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppbarWidget(title: "My Cart"),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.status == CartStatus.loading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.items.isEmpty) {
            return const _EmptyCart();
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return Card(
                      surfaceTintColor: secondaryColor,
                      elevation: 4,
                      shadowColor: primaryColor,


                      child: ListTile(

                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),

                          child: Image.network(
                            item.product.imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,

                            errorBuilder:
                                (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                          ),
                        ),
                        title: Text(
                          item.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          'Color: ${item.color}, Size: ${item.size}\nQty: ${item.quantity}',
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${item.price.toStringAsFixed(0)} Tk',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                              fontSize: 18,
                            ),
                            ),
                            SizedBox(height: 10,),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                color: Colors.red,
                                onPressed:
                                    () => context.read<CartCubit>().deleteItem(
                                  item.id,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _CartSummary(total: state.totalPrice),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 72,
            color: textPrimary,
          ),
          const SizedBox(height: 12),
          const Text('Your cart is empty',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit'
          ),
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${total.toStringAsFixed(0)} Tk',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(

                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                ),
                onPressed: () {},
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
