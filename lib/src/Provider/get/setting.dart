import 'package:dio/dio.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/get/settingModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  SettingModel userDataModel;
  String phoneNumber;
  String welcomeText;
  int orderDuration;
  int cancelDuration;
  String pullLimit;
  String chargeLimit;
  CustomDialog dialog;
  getUserData(BuildContext context) async {
    Map<String, String> headers = {};
    Response response = await _utils.get("settings", headerss: headers);
    if (response == null) {
      print('error change_password');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get settings sucsseful");

      userDataModel = SettingModel.fromJson(response.data);
      phoneNumber = userDataModel.data.phoneNumber;
      welcomeText = userDataModel.data.welcomeText;
      orderDuration = userDataModel.data.orderDuration;
      cancelDuration = userDataModel.data.cancelDuration;
      pullLimit = userDataModel.data.pullLimit;
      chargeLimit = userDataModel.data.chargeLimit;
      print('done');

      notifyListeners();
      return true;
    } else {
      print("error get settings data");
      userDataModel = SettingModel.fromJson(response.data);
      notifyListeners();
      return true;
    }
  }
}
