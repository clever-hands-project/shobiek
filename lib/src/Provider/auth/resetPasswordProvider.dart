import 'package:dio/dio.dart';
import 'package:shobek/src/MainScreens/Registeration/sign_in_screen.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/auth/resetPasswordModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:flutter/material.dart';

import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ResetPasswordProvider with ChangeNotifier {
  String phone;
  String password;
  String passwordConfirmation;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  ResetPasswordModel _model;
  resetPassword(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "country_code": 05,
    });

    Response response =
        await _utils.post("reset-password", body: formData, headerss: headers);
    if (response == null) {
      print('error reset_password');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });

      return;
    }
    if (response.statusCode == 200) {
      print("reset_password sucsseful");
      _model = ResetPasswordModel.fromJson(response.data);
    } else {
      print("error reset_password");
      _model = ResetPasswordModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(
          context: context,
          title: localization.text("password_changed"),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      });
    } else {
      print('error reset_password');
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
