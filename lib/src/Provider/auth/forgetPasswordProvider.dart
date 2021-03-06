import 'package:dio/dio.dart';
import 'package:shobek/src/MainScreens/Registeration/confirmCode.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/auth/forgetPasswordModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'confirmResetCodeProvider.dart';

class ForgetPasswordProvider with ChangeNotifier {
  String phone;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  ForgetPasswordModel model;
  forgetPassword(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "country_code": phone,
    });

    Response response =
        await _utils.post("forget-password", body: formData,);
    if (response == null) {
      print('error forgetPassword');
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
      print("forget_password sucsseful");
      model = ForgetPasswordModel.fromJson(response.data);
    } else {
      print("error forget_password");
      model = ForgetPasswordModel.fromJson(response.data);
    }
    if (model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      Provider.of<ConfirmResetCodeProvider>(context, listen: false).phone =
          phone;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ConfirmCode(
                stateOfVerificationCode: 1,
              )));
    } else {
      print('error forgetPassword');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: model.error[0].value,
          ok: localization.text("ok"),
        );
      });
    }
    notifyListeners();
  }
}
