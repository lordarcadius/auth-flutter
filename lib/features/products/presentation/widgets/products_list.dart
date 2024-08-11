import 'package:auth_flutter/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;
  const ProductsList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].name),
          subtitle: Text(products[index].price.toString()),
        );
      },
    );
  }
}
