import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/post/reportShopModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ReportShopProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  ReportShopModel reportShopModel;
  String details;
  Future<ReportShopModel> reportShop(
      int id, String token, BuildContext context) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({"details": details});
    Response response =
        await _utils.post("report-shop/$id", headerss: headers, body: formData);
    if (response.statusCode == 200) {
      print("get report-shop sucsseful");

      reportShopModel = ReportShopModel.fromJson(response.data);
      CustomAlert().toast(context: context, title: "تم الابلاغ");
      notifyListeners();
      return ReportShopModel.fromJson(response.data);
    } else {
      print("error post report-shop data");
      return ReportShopModel.fromJson(response.data);
    }
  }
}
