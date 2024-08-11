import 'dart:async';

import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:auth_flutter/core/utils/session_manager.dart';
import 'package:auth_flutter/features/products/domain/entities/product.dart';
import 'package:auth_flutter/features/products/domain/usecases/products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUsecase productsUsecase;
  ProductsBloc({required this.productsUsecase}) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) => emit(ProductsLoading()));
    on<GetProducts>(_getProducts);
  }

  Future<void> _getProducts(
    GetProducts event,
    Emitter<ProductsState> emit,
  ) async {
    final response = await productsUsecase(
        serviceLocator<UserSessionManager>().getUser()?.token ?? "");
    response.fold(
      (failure) => emit(ProductsFailure(message: failure.message)),
      (success) {
        emit(ProductsSuccess(products: success));
      },
    );
  }
}
