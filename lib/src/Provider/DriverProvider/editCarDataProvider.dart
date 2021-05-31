import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/DriverModel/carDataModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class EditCarDataProvider with ChangeNotifier {
  File identity;
  File license;
  File carForm;

  NetworkUtil _utils = new NetworkUtil();

  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  CarDataModel model;
  changeCarData(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();

    customProgressDialog.showPr();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "identity":
          identity == null ? null : await MultipartFile.fromFile(identity.path),
      "license":
          license == null ? null : await MultipartFile.fromFile(license.path),
      "car_form":
          carForm == null ? null : await MultipartFile.fromFile(carForm.path),
    });

    Response response = await _utils.post("edit-car-data", 
        body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("car data sucsseful");
      model = CarDataModel.fromJson(response.data);
      notifyListeners();
    } else {
      print("error car data");
      model = CarDataModel.fromJson(response.data);
    }
    if (model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert()
            .toast(context: context, title: "تم تغير بيانات السيارة بنجاح");
      });
      return true;
    } else {
      print("error  car data");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(context: context, title: model.error[0].value);
      });
    }
    notifyListeners();
  }
}
