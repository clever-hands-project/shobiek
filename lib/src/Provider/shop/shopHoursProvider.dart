import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/shop/shopHoursModle.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ShopHoursProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  String start;
  String end;
  ShopHoursModel _model;

  shopHours({String token, List<String> days, BuildContext context}) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "open_time": start,
      "close_time": end,
      "day_id": days,
    });

    Response response =
        await _utils.post("shop-hours", body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("shop-hours sucsseful");

      _model = ShopHoursModel.fromJson(response.data);
    } else {
      print("error shop-hours");
      _model = ShopHoursModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();

        Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .openTime = _model.data[0].openTime;
        Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .closeTime = _model.data[0].closeTime;
        Provider.of<AuthController>(context, listen: false).storageUserData(
            json.encode(Provider.of<AuthController>(context, listen: false)
                .userModel
                .toJson()));
        CustomAlert()
            .toast(context: context, title: "تم تعديل مواعيد العمل بنجاح");
        Navigator.pop(context, true);
      });
      notifyListeners();
    } else {
      print('error create-service');
      _model = ShopHoursModel.fromJson(response.data);
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(context: context, title: _model.error[0].value);
      });
    }
    notifyListeners();
  }
}
