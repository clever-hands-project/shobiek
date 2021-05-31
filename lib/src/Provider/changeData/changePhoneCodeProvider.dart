import 'package:dio/dio.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/auth/phoneVerificationModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePhoneCodeProvider with ChangeNotifier {
  String phone;
  String code;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  PhoneVerificationModel _model;
  SharedPreferences _prefs;
  changePhoneCode(String code, String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "code": code,
      "country_code": 05,
    });

    Response response = await _utils.post("check-code-change-phone",
        body: formData, headerss: headers);
    if (response == null) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        print('error check-code-change-phone');
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });

      return;
    }
    if (response.statusCode == 200) {
      print("check-code-change-phone sucsseful");
      _model = PhoneVerificationModel.fromJson(response.data);
    } else {
      print("error check-code-change-phone");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _model = PhoneVerificationModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      _prefs = await SharedPreferences.getInstance();
      print('success check-code-change-phone');
      _prefs.setString("email", phone);

      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(
          context: context,
          title: localization.text("phone_changed"),
        );
        Navigator.pop(context);
      });
      return true;
    } else {
      print('error check-code-change-phone');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(
          context: context,
          title: _model.error[0].value,
        );
      });
    }
    notifyListeners();
  }
}
