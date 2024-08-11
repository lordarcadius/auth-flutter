import 'dart:convert';


class ProductsModel {
  final String name;
  final int price;

  ProductsModel({
    required this.name,
    required this.price,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };

  static List<ProductsModel> productsModelFromJson(String str) =>
      List<ProductsModel>.from(
          json.decode(str).map((x) => ProductsModel.fromJson(x)));

  String productsModelToJson(List<ProductsModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
