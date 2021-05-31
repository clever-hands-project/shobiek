import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/chargeBankModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ChargeBankProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  ChargeBankModel subscribeModel;
  subscribe(
      String token, String price, File image, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    FormData formData = FormData.fromMap({
      "cash": price,
      "photo": image == null ? null : await MultipartFile.fromFile(image.path),
    });

    Response response = await _utils.post("charge-bank-transform",
        body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("pay data sucsseful");
      subscribeModel = ChargeBankModel.fromJson(response.data);
    } else {
      print("error  pay data");
      subscribeModel = ChargeBankModel.fromJson(response.data);
    }
    if (subscribeModel.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(title: subscribeModel.data.value, context: context);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      print('error pay');
      CustomAlert()
          .toast(title: subscribeModel.error[0].value, context: context);
    }
  }
}
