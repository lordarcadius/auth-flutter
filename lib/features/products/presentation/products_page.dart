import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:auth_flutter/core/utils/session_manager.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Products Page: ${serviceLocator<UserSessionManager>().getUser()?.email}"),
      ),
    );
  }
}
