import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/post/shopViewModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';


class ShopViewProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();

  Future<ShopViewModel> shopView(
    BuildContext context, int id) async {


    Response response =
        await _utils.get("shop-view/$id",);
    if (response.statusCode == 200) {
      print("get shop-view sucsseful");
      return ShopViewModel.fromJson(response.data);
    } else {
      print("error shop-view token");
      return ShopViewModel.fromJson(response.data);
    }
  }
}
