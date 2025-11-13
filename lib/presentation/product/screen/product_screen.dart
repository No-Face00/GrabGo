//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// import '../bloc/product_cubit.dart';
//
// class ProductsPage extends StatelessWidget {
//   const ProductsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Products')),
//       body: BlocBuilder<ProductCubit, ProductState>(
//         builder: (context, state) {
//           switch (state.status) {
//             case ProductStatus.initial:
//               context.read<ProductCubit>().loadProductsByBrandId(1);
//               return const Center(child: Text('Loading...'));
//             case ProductStatus.loading:
//               return const Center(child: CircularProgressIndicator());
//             case ProductStatus.failure:
//               return Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(state.errorMessage ?? 'Something went wrong'),
//                 ),
//               );
//             case ProductStatus.success:
//               final products = state.products;
//               if (products.isEmpty) {
//                 return const Center(child: Text('No products'));
//               }
//               return GridView.builder(
//                 padding: const EdgeInsets.all(12),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                   childAspectRatio: .68,
//                 ),
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final p = products[index];
//                   return Card(
//                     clipBehavior: Clip.antiAlias,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AspectRatio(
//                           aspectRatio: 1,
//                           child: Image.network(
//                             p.imageUrl,
//                             fit: BoxFit.cover,
//                             errorBuilder:
//                                 (_, __, ___) => const ColoredBox(
//                               color: Colors.black12,
//                               child: Center(
//                                 child: Icon(Icons.broken_image),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             p.title,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: Theme.of(context).textTheme.titleSmall,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text(
//                             '4${p.price}',
//                             style: Theme.of(context).textTheme.titleMedium
//                                 ?.copyWith(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                       ],
//                     ),
//                   );
//                 },
//               );
//           }
//         },
//       ),
//     );
//   }
// }
