import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/features/products/domain/entities/product.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> products({required String token});
}
