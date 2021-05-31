import 'package:dio/dio.dart';
import 'package:shobek/src/Models/get/productByIdModle.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class ProductByIdProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  ProducByIdrModel productId;

  Future<ProducByIdrModel> getShopById(String token, int productID) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    Response response =
        await _utils.get("product-by-id/$productID", headerss: headers);
    if (response.statusCode == 200) {
      print("get product-by-id data sucsseful");
      productId = ProducByIdrModel.fromJson(response.data);
      notifyListeners();
      return ProducByIdrModel.fromJson(response.data);
    } else {
      print("error get product-by-id data");
      productId = ProducByIdrModel.fromJson(response.data);
      notifyListeners();
      return ProducByIdrModel.fromJson(response.data);
    }
  }
}
