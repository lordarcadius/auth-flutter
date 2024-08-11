import 'package:auth_flutter/core/network/api_client.dart';
import 'package:auth_flutter/core/network/network_helper.dart';
import 'package:auth_flutter/core/network/network_service.dart';
import 'package:auth_flutter/features/products/data/datasources/products_remote_datasource.dart';
import 'package:auth_flutter/features/products/data/models/products_model.dart';

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {
  @override
  Future<List<ProductsModel>> products({required String token}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        url: ApiClient.baseUrl + ApiClient.products,
        setToken: true);
    return NetworkHelper.filterResponse(
      callBack: (json) => (json as List<dynamic>)
          .map((jsonItem) => ProductsModel.fromJson(jsonItem))
          .toList(),
      response: response,
      onFailureCallBackWithMessage: (errorType, msg) => throw "$msg",
    );
  }
}
