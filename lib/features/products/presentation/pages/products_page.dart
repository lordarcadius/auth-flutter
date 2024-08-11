import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:auth_flutter/core/widgets/loader.dart';
import 'package:auth_flutter/features/products/presentation/bloc/products_bloc.dart';
import 'package:auth_flutter/features/products/presentation/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => serviceLocator<ProductsBloc>()..add(GetProducts()),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsFailure) {
              return Text(state.message);
            } else if (state is ProductsSuccess) {
              return ProductsList(
                products: state.products,
              );
            } else {
              return const Loader();
            }
          },
        ),
      ),
    );
  }
}
