import 'package:auth_flutter/features/products/data/models/products_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductsModel>> products({required String token});
}
