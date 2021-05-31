import 'package:dio/dio.dart';
import 'package:shobek/src/Models/auth/registerMobileModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:flutter/material.dart';

import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ResendCodeProvider with ChangeNotifier {
  String phone;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  RegisterMobileModel model;

  resendCode(BuildContext context) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
    });

    Response response =
        await _utils.post("resend-code", body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("resend-code sucsseful");
      model = RegisterMobileModel.fromJson(response.data);
    } else {
      print("error resend-code");
      model = RegisterMobileModel.fromJson(response.data);
    }
    if (model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {});
    } else {
      print('error resend-code');
    }
    notifyListeners();
  }
}
