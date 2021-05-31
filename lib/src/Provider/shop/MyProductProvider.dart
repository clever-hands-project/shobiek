import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/shop/myProductModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
class ShopProuctProvider with ChangeNotifier {
  List<ShopProduct> _shopProduct = [];

  List<ShopProduct> get shopProduct {
    return [..._shopProduct];
  }

  NetworkUtil _utils = new NetworkUtil();
  MyProductsModel driverOrdersModel;
  Future<MyProductsModel> getDriverOrders(
      String token, String orderType, BuildContext context) async {
    final List<ShopProduct> loadedOrders = [];

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    // FormData formData = FormData.fromMap({"order_type": orderType});
    Response response = await _utils.get("my-products", 
         headerss: headers);
    if (response.statusCode == 200) {
      print("get products-orders sucsseful");

      driverOrdersModel = MyProductsModel.fromJson(response.data);
      driverOrdersModel.data.forEach((e) {
        loadedOrders.add(ShopProduct(
          id: e.id,
          createdAt: e.createdAt,
          available: e.available,
          category: e.category,
          categoryId: e.categoryId,
          details: e.details,
          name: e.name,
          photos: e.photos,
          price: e.price,
          shop: e.shop,
          shopId: e.shopId,
        ));
      });
      _shopProduct = loadedOrders.reversed.toList();
      notifyListeners();
      return MyProductsModel.fromJson(response.data);
    } else {
      print("error get products-orders data");
      driverOrdersModel = MyProductsModel.fromJson(response.data);

      _shopProduct = loadedOrders.reversed.toList();
      notifyListeners();
      return MyProductsModel.fromJson(response.data);
    }
  }
}
