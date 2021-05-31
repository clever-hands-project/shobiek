import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/myChargeModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class MyChargeProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  Future<MyChargeModel> getHistory(
      String token, String orderType, BuildContext context) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response =
        await _utils.get("my-balance-in-wallet", headerss: headers);
    if (response.statusCode == 200) {
      print("get my-balance-in-wallet sucsseful");

      return MyChargeModel.fromJson(response.data);
    } else {
      print("error my-balance-in-wallet data");

      return MyChargeModel.fromJson(response.data);
    }
  }
}
