import 'package:dio/dio.dart';
import 'package:shobek/src/Models/get/productsFilterModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class ProductFiltterProvider with ChangeNotifier {
  List<ProductFilter> _products = [];

  List<ProductFilter> get products {
    return [..._products];
  }

  NetworkUtil _utils = new NetworkUtil();
  ProductFiltterModel productFiltterModle;

  Future<ProductFiltterModel> getProductFiltter(
      int shopId, int categoryId) async {
    final List<ProductFilter> productsFilter = [];

    FormData formData = FormData.fromMap({
      "shop_id": shopId,
      "category_id": categoryId,
    });
    Response response = await _utils.post(
      "products-fillter",
      body: formData,
    );
    if (response.statusCode == 200) {
      print("get products-fillte data sucsseful");
      productFiltterModle = ProductFiltterModel.fromJson(response.data);
      productFiltterModle.data.forEach((e) {
        productsFilter.add(ProductFilter(
          id: e.id,
          available: e.available,
          category: e.category,
          categoryId: e.categoryId,
          details: e.details,
          name: e.name,
          photos: e.photos,
          price: e.price,
          shop: e.shop,
          shopId: e.shopId,
          createdAt: e.createdAt,
        ));
      });
      _products = productsFilter.reversed.toList();
      notifyListeners();
      return ProductFiltterModel.fromJson(response.data);
    } else {
      print("error get products-fillte data");
      productFiltterModle = ProductFiltterModel.fromJson(response.data);
      notifyListeners();
      return ProductFiltterModel.fromJson(response.data);
    }
  }
}
