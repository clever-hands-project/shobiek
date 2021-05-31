import 'package:dio/dio.dart';
import 'package:shobek/src/Models/helpCenterModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class HelpCenterProvider with ChangeNotifier {
  int phone;
  String token;
  NetworkUtil _utils = new NetworkUtil();
  HelpCenterModel callModel;
  Future<HelpCenterModel> getPhone() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Response response = await _utils.get("settings", headerss: headers);
    if (response.statusCode == 200) {
      print("get settings sucsseful");

      callModel = HelpCenterModel.fromJson(response.data);
      phone = callModel.data.phoneNumber;
      notifyListeners();
      return HelpCenterModel.fromJson(response.data);
    } else {
      print("error get settings data");
      return HelpCenterModel.fromJson(response.data);
    }
  }
}
