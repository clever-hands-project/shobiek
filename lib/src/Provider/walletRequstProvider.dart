import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/walletRequst.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class WalletRequestProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  WalletRequestModel walletRequestModel;
  Future<WalletRequestModel> walletRequest(
      BuildContext context, String token) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Response response = await _utils
        .get("my-balance-withdrawal-request", headerss: headers);
    if (response.statusCode == 200) {
      print("get my-balance-withdrawal-request sucsseful");
      walletRequestModel = WalletRequestModel.fromJson(response.data);
      CustomAlert()
          .toast(context: context, title: walletRequestModel.data[0].value);
      return WalletRequestModel.fromJson(response.data);
    } else {
      print("error my-balance-withdrawal-request data");
      walletRequestModel = WalletRequestModel.fromJson(response.data);
      CustomAlert()
          .toast(context: context, title: walletRequestModel.error[0].value);
      return WalletRequestModel.fromJson(response.data);
    }
  }
}
