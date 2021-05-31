import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/DriverModel/driverComisstionModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class DriverCommitionsProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  Future<DriverCommistionModle> getDriverCommitions(
      String token,String url , String orderType, BuildContext context) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response =
        await _utils.get(url, headerss: headers);
    if (response.statusCode == 200) {
      print("get driver-commission sucsseful");
      return DriverCommistionModle.fromJson(response.data);
    } else {
      print("error get driver-commission data");
      return DriverCommistionModle.fromJson(response.data);
    }
  }
}
