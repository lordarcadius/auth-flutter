import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/features/products/data/datasources/products_remote_datasource.dart';
import 'package:auth_flutter/features/products/domain/entities/product.dart';
import 'package:auth_flutter/features/products/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsRemoteDataSource dataSource;

  ProductsRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<Product>>> products(
      {required String token}) async {
    try {
      final response = await dataSource.products(token: token);
      List<Product> products = [];

      for (int i = 0; i < response.length; i++) {
        products.add(Product(name: response[i].name, price: response[i].price));
      }
      return right(products);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
