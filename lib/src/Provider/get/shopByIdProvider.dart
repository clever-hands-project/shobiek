import 'package:dio/dio.dart';
import 'package:shobek/src/Models/get/shopById.dart';

import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class ShopByIdProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  ShopByIdModel shopByIdModle;

  Future<ShopByIdModel> getShopById( int shopId) async {
    // Map<String, String> headers = {
    //   "X-localization": localization.currentLanguage.toString(),
    //   "Authorization": "Bearer $token"
    // };
    Response response =
        await _utils.get("get-shop-by-id/$shopId", );
    if (response.statusCode == 200) {
      print("get get-shop-by-id data sucsseful");
      shopByIdModle = ShopByIdModel.fromJson(response.data);
      notifyListeners();
      return ShopByIdModel.fromJson(response.data);
    } else {
      print("error get get-shop-by-id data");
      shopByIdModle = ShopByIdModel.fromJson(response.data);
      notifyListeners();
      return ShopByIdModel.fromJson(response.data);
    }
  }
}
