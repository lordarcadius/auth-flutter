import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/core/usecase/usecase.dart';
import 'package:auth_flutter/features/products/domain/entities/product.dart';
import 'package:auth_flutter/features/products/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductsUsecase implements UseCase<List<Product>, String> {
  final ProductsRepository repository;

  ProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(String token) async {
    return await repository.products(token: token);
  }
}
